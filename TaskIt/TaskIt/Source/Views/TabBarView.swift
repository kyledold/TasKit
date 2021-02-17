//
//  TabBarView.swift
//  TaskIt
//
//  Created by Kyle Dold on 10/02/2021.
//

import SwiftUI

struct TabBarView<ViewModel: TabBarViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        TabView {
            TasksView(viewModel: TasksViewModel(managedObjectContext: managedObjectContext))
                .tabItem {
                    Image(systemName: "list.dash")
                    Text(viewModel.tasksText)
                }
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text(viewModel.calendarText)
                }
            SettingsView(viewModel: SettingsViewModel())
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text(viewModel.settingsText)
                }
        }
        .sheet(isPresented: $viewModel.showWelcomeView) {
            WelcomeView(viewModel: WelcomeViewModel())
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(viewModel: FakeTabBarViewModel())
    }
}
