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
        case taskDetails(onChange: EmptyClosure)
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
    
    func sheetView() -> AnyView {
        switch sheetDestination {
        case .none:
            return EmptyView().eraseToAnyView()
            
        case .settings:
            return SettingsView(viewModel: SettingsViewModel()).eraseToAnyView()
            
        case .calendar:
            return CalendarView().eraseToAnyView()
        
        case .taskDetails(let onChange):
            let viewModel = makeTaskDetailsViewModel(onChange: onChange)
            return TaskDetailsView(viewModel: viewModel).eraseToAnyView()
        }
    }
    
    // MARK: - ViewModel Creation
    
    private func makeTasksViewModel() -> TasksListViewModel {
        return TasksListViewModel(managedObjectContext: managedObjectContext)
    }
    
    private func makeTaskDetailsViewModel(task: Task? = nil, onChange: @escaping EmptyClosure) -> TaskDetailsViewModel {
        return TaskDetailsViewModel(
            task: task,
            onChange: onChange,
            managedObjectContext: managedObjectContext
        )
    }
}
