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
        case editTask(task: Task, onChange: EmptyClosure)
        case addTask(onChange: EmptyClosure)
    }
    
    enum FullScreenDestination {
        case none
        case viewTask(task: Task, onChange: EmptyClosure)
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
            
        case .editTask(let task, let onChange):
            let viewModel = makeAddTaskViewModel(task: task, onChange: onChange)
            return AddTaskView(viewModel: viewModel).eraseToAnyView()
        
        case .addTask(let onChange):
            let viewModel = makeAddTaskViewModel(onChange: onChange)
            return AddTaskView(viewModel: viewModel).eraseToAnyView()
        }
    }
    
    func fullScreenView() -> AnyView {
        switch fullScreenDestination {
        case .none:
            return Text(String.empty).eraseToAnyView()
            
        case .viewTask(let task, let onChange):
            let viewModel = makeTaskDetailsViewModel(with: task, onChange: onChange)
            return TaskDetailsView(viewModel: viewModel, navigator: self).eraseToAnyView()
        }
    }
    
    // MARK: - ViewModel Creation
    
    private func makeTasksViewModel() -> TasksListViewModel {
        return TasksListViewModel(managedObjectContext: managedObjectContext)
    }
    
    private func makeAddTaskViewModel(task: Task? = nil, onChange: @escaping EmptyClosure) -> AddTaskViewModel {
        return AddTaskViewModel(
            task: task,
            onChange: onChange,
            managedObjectContext: managedObjectContext
        )
    }
    
    private func makeTaskDetailsViewModel(with task: Task, onChange: @escaping EmptyClosure) -> TaskDetailsViewModel {
        return TaskDetailsViewModel(
            task: task,
            onChange: onChange,
            managedObjectContext: managedObjectContext
        )
    }
}
