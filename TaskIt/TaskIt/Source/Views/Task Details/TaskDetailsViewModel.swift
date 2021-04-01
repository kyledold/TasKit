//
//  TaskDetailsViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import Combine
import CoreData
import Foundation
import EventKit
import UserNotifications

class TaskDetailsViewModel: TaskDetailsViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var taskName = String.empty
    @Published var dueDate = Date()
    @Published var dueTime = Date()
    @Published var isComplete = false
    @Published var taskNotes = String.empty
    @Published var formattedDueDate = String.empty
    @Published var showCalendarView: Bool
    @Published var isTimeToggledOn: Bool
    @Published var isReminderToggledOn: Bool
    
    var deleteAlertTitleText = NSLocalizedString("task_details.delete_alert.title", comment: "Delete alert title")
    var deleteAlertMessageText = NSLocalizedString("task_details.delete_alert.message", comment: "Delete alert message")
    var deleteButtonText = NSLocalizedString("task_details.delete", comment: "Delete button title")
    var reminderText = NSLocalizedString("task_details.reminder", comment: "Reminder label")
    var taskNamePlaceholderText = NSLocalizedString("task_details.task_name_placeholder", comment: "Task name textfield placeholder")
    var taskNotesPlaceholderText = NSLocalizedString("task_details.task_notes_placeholder", comment: "Task notes text editor placeholder")
    var taskDateText = NSLocalizedString("task_details.date", comment: "Date picker description")
    var timeText = NSLocalizedString("task_details.time", comment: "Time label")
    private let reminderTitle = NSLocalizedString("user_notification.title", comment: "Notification title")
    
    var subTaskListViewModel: SubTaskListViewModel
    var onDateChanged: EmptyClosure
    
    private let calendar = Calendar.current
    private var subscribers: Set<AnyCancellable> = []
    private let notificationCenter = NotificationCenter.default
    private let userNotificationCenter = UNUserNotificationCenter.current()
    private let managedObjectContext: NSManagedObjectContext
    private let task: Task
    
    // MARK: - Initialisation
    
    init(task: Task, onDateChanged: @escaping EmptyClosure, managedObjectContext: NSManagedObjectContext) {
        self.task = task
        self.onDateChanged = onDateChanged
        self.managedObjectContext = managedObjectContext
        self.subTaskListViewModel = SubTaskListViewModel(task: self.task, managedObjectContext: managedObjectContext)
        
        taskName = task.title
        dueDate = task.dueDate
        dueTime = task.unwrappedDueTime
        isComplete = task.isComplete
        taskNotes = task.unwrappedNotes
        showCalendarView = false
        
        isTimeToggledOn = task.dueTime != nil
        isReminderToggledOn = task.isReminderSet
        formattedDueDate = task.dueDate.shortDate
        
        addObservers()
    }
    
    // MARK: - Events
    
    func deleteButtonTapped(_ completion: @escaping EmptyClosure) {
        Task.deleteTask(task: task, viewContext: managedObjectContext)
        
        notificationCenter.post(name: .taskDeleted, object: nil)
        completion()
    }
    
    func calendarButtonTapped() {
        showCalendarView = true
    }

    // MARK: - CoreDate Operations
    
    private func updateTaskNotes(_ taskNotes: String) {
        Task.updateNotes(
            task: task,
            notes: taskNotes,
            viewContext: managedObjectContext
        )
    }
    
    private func updateTaskDueDate(_ dueDate: Date) {
        
        if isTimeToggledOn {
            // we update task time date but ignore the time component of the new date
            let newDueTime = dueDate.setTime(hour: dueTime.get(.hour), minute: dueTime.get(.minute))
            updateTaskDueTime(newDueTime)
        }
        
        Task.updateDueDate(
            task: task,
            dueDate: dueDate,
            viewContext: managedObjectContext
        )
        
        onDateChanged()
    }
    
    private func updateTaskDueTime(_ dueTime: Date?) {
        Task.updateDueTime(
            task: task,
            dueTime: dueTime,
            viewContext: managedObjectContext
        )
        
        if task.isReminderSet {
            
            // delete old reminder
            deleteReminder()
            
            // add new reminder, I added a delay here because there is a weird race condition with delete
            // before adding that causes the notification not to be set
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                self?.setReminder()
            }
        }
    }
    
    private func updateTaskName(_ taskName: String) {
        Task.updateTitle(
            task: task,
            title: taskName,
            viewContext: managedObjectContext
        )
    }
    
    private func updateIsReminderSet(_ isReminderSet: Bool) {
        Task.updateIsReminderSet(
            task: task,
            isReminderSet: isReminderSet,
            viewContext: managedObjectContext
        )
    }
    
    private func updateCompletionStatus(_ isComplete: Bool) {
        Task.updateCompletionStatus(
            task: task,
            isComplete: isComplete,
            viewContext: managedObjectContext
        )
    }
    
    // MARK: - Child ViewModels
    
    lazy var calendarViewModel: CalendarViewModel = {
        let calendarViewModel = CalendarViewModel(selectedDate: dueDate)
        calendarViewModel.onDateSelected = { [weak self] selectedDate in
            self?.dueDate = selectedDate
            self?.formattedDueDate = selectedDate.shortDate
            self?.showCalendarView = false
        }
        
        return calendarViewModel
    }()
}

// MARK: - User Notifications -

extension TaskDetailsViewModel {
    
    private func requestNotificationAuthorization() {
        
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }
    
    private func setReminder() {
        let content = UNMutableNotificationContent()
        content.title = String(format: reminderTitle, task.title)
        content.body = task.unwrappedNotes
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dueTime), repeats: false)
        let request = UNNotificationRequest(identifier: task.id.uuidString, content: content, trigger: trigger)
        
        userNotificationCenter.add(request, withCompletionHandler: { [weak self] error in
            if let error = error {
                print("Notification Error: ", error)
                return
            }
            
            print("Reminder set for \(String(describing: self?.dueTime))")
            self?.updateIsReminderSet(true)
        })
    }
    
    private func deleteReminder() {
        userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [task.id.uuidString])
        print("Reminder deleted")
        
        updateIsReminderSet(false)
    }
}

// MARK: - Observers -

extension TaskDetailsViewModel {
    
    private func addObservers() {
        
        $isComplete.dropFirst().sink { [weak self] isComplete in
            self?.updateCompletionStatus(isComplete)
        }.store(in: &subscribers)
        
        $taskName.dropFirst().sink { [weak self] taskName in
            self?.updateTaskName(taskName)
        }.store(in: &subscribers)
        
        $dueDate.dropFirst().sink { [weak self] dueDate in
            self?.updateTaskDueDate(dueDate)
        }.store(in: &subscribers)
        
        $dueTime.dropFirst().sink { [weak self] dueTime in
            self?.updateTaskDueTime(dueTime)
        }.store(in: &subscribers)
        
        $isTimeToggledOn.dropFirst().sink { [weak self] isTimeEnabled in
            guard let self = self else { return }
            
            if !isTimeEnabled {
                self.updateTaskDueTime(nil)
            } else {
                self.updateTaskDueTime(self.dueTime)
            }
        }.store(in: &subscribers)
        
        $taskNotes.dropFirst().sink { [weak self] taskNotes in
            self?.updateTaskNotes(taskNotes)
        }.store(in: &subscribers)
        
        $isReminderToggledOn.dropFirst().sink { [weak self] isReminderEnabled in
            
            guard let self = self else { return }
            
            self.requestNotificationAuthorization()
            if isReminderEnabled {
                self.setReminder()
            } else {
                self.deleteReminder()
            }
            
        }.store(in: &subscribers)
    }
}
