//
//  FakeWelcomeViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

class FakeWelcomeViewModel: WelcomeViewModelProtocol {
    
    var welcomeTextKey = "welcome.welcome"
    var getStartedButtonTextKey = "welcome.get_started"
    var disclaimerTextKey = "welcome.terms_and_conditions"
    
    func onGetStartedTapped() {}
}
