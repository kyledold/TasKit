//
//  TabBarViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

import Foundation
import Combine

protocol TabBarViewModelProtocol: ObservableObject {
    
    var tasksTextKey: String { get set }
    var calendarTextKey: String { get set }
    var settingsTextKey: String { get set }
    var showWelcomeView: Bool { get set }
}
