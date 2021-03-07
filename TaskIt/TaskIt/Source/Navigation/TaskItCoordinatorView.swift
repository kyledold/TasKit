//
//  TaskItCoordinatorView.swift
//  TaskIt
//
//  Created by Kyle Dold on 07/03/2021.
//

import SwiftUI

struct TaskItCoordinatorView: View {

    @ObservedObject var coordinator: TaskItCoordinator

    var body: some View {
        NavigationView {
            TasksListView(
                viewModel: coordinator.tasksListViewModel,
                settingsModifier: SheetModifier(item: $coordinator.settingsViewModel) { settingsViewModel in
                    NavigationView {
                        SettingsView(viewModel: settingsViewModel)
                    }
                },
                calendarModifier: SheetModifier(item: $coordinator.calendarViewModel) { calendarViewModel in
                    NavigationView {
                        CalendarView(viewModel: calendarViewModel)
                    }
                }
            ).navigation(item: $coordinator.taskDetailViewModel) { viewModel in
                TaskDetailsView(viewModel: viewModel)
            }
        }
    }
}
