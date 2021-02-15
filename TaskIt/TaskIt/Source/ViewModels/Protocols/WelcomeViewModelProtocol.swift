//
//  WelcomeViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

protocol WelcomeViewModelProtocol {
    
    var welcomeText: String { get }
    var gotItButtonText: String { get }
    var disclaimerText: String { get }
    
    func onGotItTapped()
}
