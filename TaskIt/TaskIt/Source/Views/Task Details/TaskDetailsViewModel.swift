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

class TaskDetailsViewModel: TaskDetailsViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var taskName = String.empty
    @Published var dueDate = Date()
    @Published var dueTime = Date()
    @Published var isComplete = false
    @Published var taskNotes = String.empty
    @Published var formattedDueDate = String.empty
    @Published var showCalendarView: Bool
    @Published var isTimeEnabled: Bool
    @Published var isReminderEnabled: Bool
    
    var deleteAlertTitleText = NSLocalizedString("task_details.delete_alert.title", comment: "Delete alert title")
    var deleteAlertMessageText = NSLocalizedString("task_details.delete_alert.message", comment: "Delete alert message")
    var deleteButtonText = NSLocalizedString("task_details.delete", comment: "Delete button title")
    var reminderText = NSLocalizedString("task_details.reminder", comment: "Reminder label")
    var taskNamePlaceholderText = NSLocalizedString("task_details.task_name_placeholder", comment: "Task name textfield placeholder")
    var taskNotesPlaceholderText = NSLocalizedString("task_details.task_notes_placeholder", comment: "Task notes text editor placeholder")
    var taskDateText = NSLocalizedString("task_details.date", comment: "Date picker description")
    var timeText = NSLocalizedString("task_details.time", comment: "Time label")
    
    var subTaskListViewModel: SubTaskListViewModel
    
    private let calendar = Calendar.current
    private var subscribers: Set<AnyCancellable> = []
    private let notificationCenter = NotificationCenter.default
    private let managedObjectContext: NSManagedObjectContext
    private let task: Task
    
    // MARK: - Initialisation
    
    init(task: Task, managedObjectContext: NSManagedObjectContext) {
        self.task = task
        self.managedObjectContext = managedObjectContext
        self.subTaskListViewModel = SubTaskListViewModel(task: self.task, managedObjectContext: managedObjectContext)
        
        taskName = task.unwrappedTitle
        dueDate = task.unwrappedDueDate
        dueTime = task.unwrappedDueTime
        isComplete = task.status == .completed
        taskNotes = task.unwrappedNotes
        showCalendarView = false
        
        isTimeEnabled = task.dueTime != nil
        isReminderEnabled = task.reminderTimeInterval != nil
        formattedDueDate = task.unwrappedDueDate.shortDate
        
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
    
    private func updateTaskDueDate(_ dueDate: Date?) {
        
        if isTimeEnabled {
            // we update task time date but ignore the time component of the new date
            let newDueTime = dueDate?.setTime(hour: dueTime.get(.hour), minute: dueTime.get(.minute))
            updateTaskDueTime(newDueTime)
        }
        
        Task.updateDueDate(
            task: task,
            dueDate: dueDate,
            viewContext: managedObjectContext
        )
    }
    
    private func updateTaskDueTime(_ dueTime: Date?) {
        Task.updateDueTime(
            task: task,
            dueTime: dueTime,
            viewContext: managedObjectContext
        )
    }
    
    private func updateTaskName(_ taskName: String) {
        Task.updateTitle(
            task: task,
            title: taskName,
            viewContext: managedObjectContext
        )
    }
    
    private func updateCompletionStatus(_ isComplete: Bool) {
        Task.updateStatus(
            task: task,
            newStatus: isComplete ? .completed : .todo,
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

// MARK: - Observers

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
        
        $isTimeEnabled.dropFirst().sink { [weak self] isTimeEnabled in
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
        
        $isReminderEnabled.dropFirst().sink { [weak self] isReminderEnabled in
            
            guard let self = self else { return }
            
            let store = EKEventStore()
            store.requestAccess(to: .reminder) { (granted, error) in
              if let error = error {
                print("request access error: \(error)")
              } else if granted {
                
                guard let reminderCalendar = store.defaultCalendarForNewReminders() else { return }
                
                let newReminder = EKReminder(eventStore: store)
                newReminder.calendar = reminderCalendar
                newReminder.title = self.task.title
                newReminder.dueDateComponents = self.calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self.task.unwrappedDueTime)

                try! store.save(newReminder, commit: true)

              } else {
                print("access denied")
              }
            }
        }.store(in: &subscribers)
    }
}
