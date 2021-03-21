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
    @Published var dueDate: Date?
    @Published var isComplete = false
    @Published var taskNotes = String.empty
    @Published var formattedDueDate = String.empty
    @Published var showCalendarView: Bool
    @Published var reminderTimeInterval: TimeInterval
    @Published var isDateEnabled: Bool
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
    private var selectedDateText = NSLocalizedString("task_details.select_date", comment: "Select data text")
    
    var subTaskListViewModel: SubTaskListViewModel
    
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
        dueDate = task.dueDate
        isComplete = task.status == .completed
        taskNotes = task.unwrappedNotes
        reminderTimeInterval = TimeInterval()
        showCalendarView = false
        
        isDateEnabled = task.dueDate != nil
        isTimeEnabled = task.dueTime != nil
        isReminderEnabled = task.reminderTimeInterval != nil
        formattedDueDate = task.dueDate?.shortDate ?? selectedDateText
        
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
    
    // MARK: - Observers
    
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
        
        $isDateEnabled.dropFirst().sink { [weak self] isDateEnabled in
            self?.updateTaskDueDate(nil)
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
                
                guard let calendar = store.defaultCalendarForNewReminders() else { return }
                let newReminder = EKReminder(eventStore: store)
                newReminder.calendar = calendar
                newReminder.title = "Buy coffee"
                
                //let dueDate = task.dueDate.addingTimeInterval()
                //newReminder.dueDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: dueDate)

                try! store.save(newReminder, commit: true)

              } else {
                print("access denied")
              }
            }
        }.store(in: &subscribers)
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
        Task.updateDueDate(
            task: task,
            dueDate: dueDate,
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
        let calendarViewModel = CalendarViewModel(selectedDate: dueDate ?? Date())
        calendarViewModel.onDateSelected = { [weak self] selectedDate in
            self?.dueDate = selectedDate
            self?.formattedDueDate = selectedDate.shortDate
            self?.showCalendarView = false
        }
        
        return calendarViewModel
    }()
}
