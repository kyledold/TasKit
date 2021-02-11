//
//  WelcomeViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

import Foundation

protocol WelcomeViewModelProtocol {
    
    var welcomeTextKey: String { get set }
    var getStartedButtonTextKey: String { get set }
    var disclaimerTextKey: String { get set }
    
    func onGetStartedTapped()
}
