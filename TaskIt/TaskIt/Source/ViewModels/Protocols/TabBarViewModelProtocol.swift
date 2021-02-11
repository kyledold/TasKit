//
//  TabBarViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

import Foundation

protocol TabBarViewModelProtocol {
    
    var tasksTextKey: String { get set }
    var calendarTextKey: String { get set }
    var settingsTextKey: String { get set }
}
