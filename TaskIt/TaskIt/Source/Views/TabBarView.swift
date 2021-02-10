//
//  TabBarView.swift
//  TaskIt
//
//  Created by Kyle Dold on 10/02/2021.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView {
            TasksView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text(LocalizedStringKey("tab_bar.tasks"))
                }
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text(LocalizedStringKey("tab_bar.calendar"))
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
