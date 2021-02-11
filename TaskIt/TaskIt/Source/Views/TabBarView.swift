//
//  TabBarView.swift
//  TaskIt
//
//  Created by Kyle Dold on 10/02/2021.
//

import SwiftUI

struct TabBarView<ViewModel: TabBarViewModelProtocol>: View {
    
    var viewModel: ViewModel
    
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
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(viewModel: FakeTabBarViewModel())
    }
}
