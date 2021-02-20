//
//  TasksCoodinator.swift
//  TaskIt
//
//  Created by Kyle Dold on 20/02/2021.
//

import SwiftUI

class TasksCoordinator: ObservableObject {
    
    enum SheetDestination {
        case none
        case settings
        case calendar
        case viewTask
        case addTask
    }
    
    var sheetDestination: SheetDestination = .none {
        didSet {
            showSheet = true
        }
    }
        
    @Published var showSheet = false
    
    func sheetView() -> AnyView {
        switch sheetDestination {
        case .none:
            return Text(String.empty).eraseToAnyView()
        case .settings:
            return SettingsView(viewModel: SettingsViewModel()).eraseToAnyView()
        case .calendar:
            return CalendarView().eraseToAnyView()
        case .viewTask:
            return SettingsView(viewModel: SettingsViewModel()).eraseToAnyView()
        case .addTask:
            return SettingsView(viewModel: SettingsViewModel()).eraseToAnyView()
        }
    }
}
