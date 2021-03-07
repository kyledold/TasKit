//
//  TaskItCoordinator.swift
//  TaskIt
//
//  Created by Kyle Dold on 07/03/2021.
//

import CoreData
import SwiftUI

class TaskItCoordinator: ObservableObject, Identifiable {

    // MARK: - Properties

    @Published var taskDetailViewModel: TaskDetailsViewModel?
    @Published var settingsViewModel: SettingsViewModel?
    @Published var calendarViewModel: CalendarViewModel?
    
    lazy var tasksListViewModel: TasksListViewModel = {
        TasksListViewModel(coordinator: self, managedObjectContext: managedObjectContext)
    }()
    
    private let managedObjectContext: NSManagedObjectContext

    // MARK: - Initialization
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    convenience init() {
        self.init(managedObjectContext: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
    }

    // MARK: - Functions

    func open(_ taskRowViewModel: TaskRowViewModel) {
        taskDetailViewModel = makeTaskDetailsViewModel(task: taskRowViewModel.task, onChange: { })
    }
    
    func openSettings() {
        settingsViewModel = SettingsViewModel()
    }
    
    func openCalendar() {
        calendarViewModel = CalendarViewModel()
    }
    
    // MARK: - Make
    
    private func makeTaskDetailsViewModel(task: Task, onChange: @escaping EmptyClosure) -> TaskDetailsViewModel {
        return TaskDetailsViewModel(
            task: task,
            onChange: onChange,
            managedObjectContext: managedObjectContext
        )
    }
}
