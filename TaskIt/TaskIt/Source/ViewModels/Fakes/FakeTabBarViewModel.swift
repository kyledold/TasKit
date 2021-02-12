//
//  FakeTabBarViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

import Combine

class FakeTabBarViewModel: TabBarViewModelProtocol, ObservableObject {
    
    var tasksTextKey = "tab_bar.tasks"
    var calendarTextKey = "tab_bar.calendar"
    var settingsTextKey = "tab_bar.settings"
    var showWelcomeView = false
}
