//
//  TaskItApp.swift
//  TaskIt
//
//  Created by Kyle Dold on 31/01/2021.
//

import SwiftUI

@main
struct TaskItApp: App {
    
    private var welcomeHasBeenViewed: Bool {
        return UserDefaults.standard.bool(forKey: Constants.UserDefaults.welcomeViewedKey)
    }
    
    var body: some Scene {
        WindowGroup {
            if welcomeHasBeenViewed {
                TabBarView(viewModel: TabBarViewModel())
            } else {
                WelcomeView<WelcomeViewModel>(viewModel: WelcomeViewModel())
            }
        }
    }
}
