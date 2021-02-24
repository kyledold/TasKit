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
        case editTask(task: Task)
        case addTask
    }
    
    enum FullScreenDestination {
        case none
        case viewTask(task: Task)
    }
    
    // MARK: - Properties
    
    var initialView: AnyView {
        return TasksListView(
            viewModel: makeTasksViewModel(),
            navigator: self,
            toastPresenter: ToastPresenter()
        ).eraseToAnyView()
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
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    }
    
    // MARK: - View Creation
    
    func sheetView() -> AnyView {
        switch sheetDestination {
        case .none:
            return EmptyView().eraseToAnyView()
            
        case .settings:
            return SettingsView(viewModel: SettingsViewModel()).eraseToAnyView()
            
        case .calendar:
            return CalendarView().eraseToAnyView()
            
        case .editTask(let task):
            return AddTaskView(viewModel: makeAddTaskViewModel(task: task)).eraseToAnyView()
        
        case .addTask:
            return AddTaskView(viewModel: makeAddTaskViewModel()).eraseToAnyView()
        }
    }
    
    func fullScreenView() -> AnyView {
        switch fullScreenDestination {
        case .none:
            return Text(String.empty).eraseToAnyView()
            
        case .viewTask(let task):
            return TaskDetailsView(viewModel: makeTaskDetailsViewModel(with: task), navigator: self).eraseToAnyView()
        }
    }
    
    // MARK: - ViewModel Creation
    
    private func makeTasksViewModel() -> TasksListViewModel {
        return TasksListViewModel(managedObjectContext: managedObjectContext)
    }
    
    private func makeAddTaskViewModel(task: Task? = nil) -> AddTaskViewModel {
        return AddTaskViewModel(
            task: task,
            managedObjectContext: managedObjectContext,
            onTaskAdded: {}
        )
    }
    
    private func makeTaskDetailsViewModel(with task: Task) -> TaskDetailsViewModel {
        return TaskDetailsViewModel(
            task: task,
            
            managedObjectContext: managedObjectContext
        )
    }
}
