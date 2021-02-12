//
//  TabBarViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

import Combine

class TabBarViewModel: TabBarViewModelProtocol {

    var tasksTextKey = "tab_bar.tasks"
    var calendarTextKey = "tab_bar.calendar"
    var settingsTextKey = "tab_bar.settings"
    
    @Published var showWelcomeView: Bool
    
    init() {
        #if DEBUG
        showWelcomeView = true
        #else
        showWelcomeView = UserDefaults.standard.bool(forKey: Constants.UserDefaults.welcomeViewedKey)
        #endif
    }
}
