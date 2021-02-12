//
//  FakeWelcomeViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

class FakeWelcomeViewModel: WelcomeViewModelProtocol {
    
    var welcomeTextKey = "welcome.welcome"
    var gotItButtonTextKey = "welcome.got_it"
    var disclaimerTextKey = "welcome.terms_and_conditions"
    
    func onGotItTapped() {}
}
