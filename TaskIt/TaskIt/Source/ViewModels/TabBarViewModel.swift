//
//  TabBarViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

import Combine
import Foundation

class TabBarViewModel: TabBarViewModelProtocol {

    var tasksText = NSLocalizedString("tab_bar.tasks", comment: "tasks tab name")
    var calendarText = NSLocalizedString("tab_bar.calendar", comment: "calendar tab name")
    var settingsText = NSLocalizedString("tab_bar.settings", comment: "settings tab name")
    
    @Published var showWelcomeView: Bool
    
    init() {
        showWelcomeView = false
        /*#if DEBUG
        showWelcomeView = true
        #else
        showWelcomeView = UserDefaults.standard.bool(forKey: Constants.UserDefaults.welcomeViewedKey)
        #endif*/
    }
}
