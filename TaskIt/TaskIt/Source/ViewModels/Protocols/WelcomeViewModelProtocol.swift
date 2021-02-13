//
//  WelcomeViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

protocol WelcomeViewModelProtocol {
    
    var welcomeTextKey: String { get }
    var gotItButtonTextKey: String { get }
    var disclaimerTextKey: String { get }
    
    func onGotItTapped()
}
