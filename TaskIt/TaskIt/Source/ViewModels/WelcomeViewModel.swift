//
//  WelcomeViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 10/02/2021.
//

import SwiftUI
import Foundation

class WelcomeViewModel: WelcomeViewModelProtocol {

    var welcomeTextKey = "welcome.welcome"
    var getStartedButtonTextKey = "welcome.get_started"
    var disclaimerTextKey = "welcome.terms_and_conditions"
    
    private let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func onGetStartedTapped() {
        userDefaults.set(true, forKey: Constants.UserDefaults.welcomeViewedKey)
    }
}
