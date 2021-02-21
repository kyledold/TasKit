//
//  TasksNavigator.swift
//  TaskIt
//
//  Created by Kyle Dold on 20/02/2021.
//

import CoreData
import SwiftUI

class TasksNavigator: ObservableObject {
    
    // MARK: - Destinations
    
    enum SheetDestination {
        case none
        case settings
        case calendar
    }
    
    enum FullScreenDestination {
        case none
        case viewTask(taskRowViewModel: TaskRowViewModel)
        case addTask
    }
    
    // MARK: - Properties
    
    var initialView: AnyView {
        let viewModel = makeTasksViewModel()
        return TasksView(viewModel: viewModel, navigator: self).eraseToAnyView()
    }
    
    var sheetDestination: SheetDestination = .none {
        didSet {
            showSheet = true
        }
    }
    
    var fullScreenDestination: FullScreenDestination = .none {
        didSet {
            showFullScreen = true
        }
    }

    @Published var showSheet = false
    @Published var showFullScreen = false
    
    private let managedObjectContext: NSManagedObjectContext
    
    // MARK: - Initialisation
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    init() {
        self.managedObjectContext = NSManagedObjectContext()
    }
    
    // MARK: - View Creation
    
    func sheetView() -> AnyView {
        switch sheetDestination {
        case .none:
            return Text(String.empty).eraseToAnyView()
            
        case .settings:
            return SettingsView(viewModel: SettingsViewModel()).eraseToAnyView()
            
        case .calendar:
            return CalendarView().eraseToAnyView()
        }
    }
    
    func fullScreenView() -> AnyView {
        switch fullScreenDestination {
        case .none:
            return Text(String.empty).eraseToAnyView()
            
        case .viewTask(let taskRowViewModel):
            return TaskView(viewModel: makeTaskViewModel(with: taskRowViewModel)).eraseToAnyView()
            
        case .addTask:
            return AddTaskView(viewModel: makeAddTaskViewModel()).eraseToAnyView()
        }
    }
    
    // MARK: - ViewModel Creation
    
    private func makeTasksViewModel() -> TasksViewModel {
        return TasksViewModel(managedObjectContext: managedObjectContext)
    }
    
    private func makeAddTaskViewModel() -> AddTaskViewModel {
        return AddTaskViewModel(
            managedObjectContext: managedObjectContext,
            onTaskAdded: {}
        )
    }
    
    private func makeTaskViewModel(with taskRowViewModel: TaskRowViewModel) -> TaskViewModel {
        return TaskViewModel(task: taskRowViewModel.task)
    }
}
