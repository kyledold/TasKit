//
//  TaskItCoordinator.swift
//  TaskIt
//
//  Created by Kyle Dold on 20/02/2021.
//

import CoreData
import SwiftUI

class TaskItCoordinator: ObservableObject {
    
    // MARK: - Destinations
    
    enum SheetDestination {
        case none
        case settings
        case calendar
        case taskDetails(task: Task, onChange: EmptyClosure)
    }
    
    // MARK: - Properties
    
    var initialView: some View {
        return TasksListView(
            viewModel: makeTasksViewModel(),
            navigator: self,
            toastPresenter: ToastPresenter()
        )
    }
    
    var sheetDestination: SheetDestination = .none {
        didSet {
            showSheet = true
        }
    }

    @Published var showSheet = false
    
    private let managedObjectContext: NSManagedObjectContext
    
    // MARK: - Initialisation
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    init() {
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    }
    
    // MARK: - View Creation
    
    @ViewBuilder
    func sheetView() -> some View {
        switch sheetDestination {
        case .none:
            EmptyView()
            
        case .settings:
            SettingsView(viewModel: SettingsViewModel())
            
        case .calendar:
            CalendarView()
            
        case .taskDetails(let task, let onChange):
            let viewModel = makeTaskDetailsViewModel(task: task, onChange: onChange)
            TaskDetailsView(viewModel: viewModel)
        }
    }
    
    // MARK: - ViewModel Creation
    
    private func makeTasksViewModel() -> TasksListViewModel {
        return TasksListViewModel(managedObjectContext: managedObjectContext)
    }
    
    private func makeTaskDetailsViewModel(task: Task, onChange: @escaping EmptyClosure) -> TaskDetailsViewModel {
        return TaskDetailsViewModel(
            task: task,
            onChange: onChange,
            managedObjectContext: managedObjectContext
        )
    }
}
