//
//  WelcomeViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 10/02/2021.
//

import Foundation

class WelcomeViewModel: WelcomeViewModelProtocol {

    var welcomeText = NSLocalizedString("welcome.welcome", comment: "Welcome page heading")
    var gotItButtonText = NSLocalizedString("welcome.got_it", comment: "Got it button text")
    var disclaimerText = NSLocalizedString("welcome.terms_and_conditions", comment: "disclaimer text")
    
    private let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func onGotItTapped() {
        userDefaults.set(true, forKey: Constants.UserDefaults.welcomeViewedKey)
    }
}
