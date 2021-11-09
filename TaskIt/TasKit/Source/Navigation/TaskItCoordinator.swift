//
//  TasKitCoordinator.swift
//  TasKit
//
//  Created by Kyle Dold on 07/03/2021.
//

import CoreData
import SwiftUI

class TaskItCoordinator: ObservableObject, Identifiable {

    // MARK: - Properties

    @Published var taskDetailViewModel: TaskDetailsViewModel?
    @Published var settingsViewModel: SettingsViewModel?
    
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

    func showTaskDetails(_ taskRowViewModel: TaskRowViewModel, onDateChanged: @escaping EmptyClosure) {
        taskDetailViewModel = makeTaskDetailsViewModel(task: taskRowViewModel.task, onDateChanged: onDateChanged)
    }
    
    func showSettings() {
        settingsViewModel = SettingsViewModel()
    }
    
    // MARK: - Make
    
    private func makeTaskDetailsViewModel(task: Task, onDateChanged: @escaping EmptyClosure) -> TaskDetailsViewModel {
        return TaskDetailsViewModel(
            task: task,
            onDateChanged: onDateChanged,
            managedObjectContext: managedObjectContext
        )
    }
}
