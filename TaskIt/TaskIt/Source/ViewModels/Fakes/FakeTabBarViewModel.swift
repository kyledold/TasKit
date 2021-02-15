//
//  FakeTabBarViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

import Combine

class FakeTabBarViewModel: TabBarViewModelProtocol, ObservableObject {
    
    var tasksText = "Tasks"
    var calendarText = "Calendar"
    var settingsText = "Settings"
    var showWelcomeView = false
}
