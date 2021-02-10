//
//  WelcomeViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 10/02/2021.
//

import SwiftUI
import Foundation

class WelcomeViewModel {

    let welcomeText = LocalizedStringKey("welcome.welcome")
    let getStartedButtonText = LocalizedStringKey("welcome.get_started")
    let disclaimerText = LocalizedStringKey("welcome.terms_and_conditions")
    
    private let userDefaults = UserDefaults.standard
    
    func onGetStartedTapped() {
        userDefaults.set(true, forKey: Constants.UserDefaults.welcomeViewedKey)
    }
}
