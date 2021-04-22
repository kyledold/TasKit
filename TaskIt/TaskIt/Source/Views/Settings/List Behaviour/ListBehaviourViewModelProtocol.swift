//
//  ListBehaviourViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/04/2021.
//

import Foundation

protocol ListBehaviourViewModelProtocol: ObservableObject {
    
    var titleText: String { get }
    
    var showSubTasksText: String { get }
    var showSubTasksDescription: String { get }
    var isShowSubTasksEnabled: Bool { get set }
    
    var showReminderText: String { get }
    var showReminderDescription: String { get }
    var isReminderEnabled: Bool { get set }
    
    var moveIncompleteTasksText: String { get }
    var moveIncompleteTasksDescription: String { get }
    var isMoveInompleteTasksEnabled: Bool { get set }
}
