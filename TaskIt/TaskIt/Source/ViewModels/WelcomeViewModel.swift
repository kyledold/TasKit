//
//  WelcomeViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 10/02/2021.
//

import Foundation

class WelcomeViewModel: WelcomeViewModelProtocol {

    var welcomeTextKey = "welcome.welcome"
    var gotItButtonTextKey = "welcome.got_it"
    var disclaimerTextKey = "welcome.terms_and_conditions"
    
    private let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func onGotItTapped() {
        userDefaults.set(true, forKey: Constants.UserDefaults.welcomeViewedKey)
    }
}
