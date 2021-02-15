//
//  TabBarViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

import Combine

protocol TabBarViewModelProtocol: ObservableObject {
    
    var tasksText: String { get }
    var calendarText: String { get }
    var settingsText: String { get }
    var showWelcomeView: Bool { get set }
}
