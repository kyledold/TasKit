//
//  TabBarView.swift
//  TaskIt
//
//  Created by Kyle Dold on 10/02/2021.
//

import SwiftUI

struct TabBarView<ViewModel: TabBarViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        TabView {
            TasksView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text(LocalizedStringKey(viewModel.tasksTextKey))
                }
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text(LocalizedStringKey(viewModel.calendarTextKey))
                }
            SettingsView(viewModel: SettingsViewModel())
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text(LocalizedStringKey(viewModel.settingsTextKey))
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
