//
//  FakeWelcomeViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

class FakeWelcomeViewModel: WelcomeViewModelProtocol {
    
    var welcomeText = "welcome.welcome"
    var gotItButtonText = "welcome.got_it"
    var disclaimerText = "welcome.terms_and_conditions"
    
    func onGotItTapped() {}
}
