//
//  TabBarViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

import Foundation
import Combine

protocol TabBarViewModelProtocol: ObservableObject {
    
    var tasksTextKey: String { get }
    var calendarTextKey: String { get }
    var settingsTextKey: String { get }
    var showWelcomeView: Bool { get set }
}
