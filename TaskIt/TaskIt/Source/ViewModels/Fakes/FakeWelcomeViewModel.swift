//
//  FakeWelcomeViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

class FakeWelcomeViewModel: WelcomeViewModelProtocol {
    
    var welcomeText = "Welcome"
    var gotItButtonText = "Got it"
    var disclaimerText = "By continuing you agree to Task Its Terms of Service and Privacy Policy"
    
    func onGotItTapped() {}
}
