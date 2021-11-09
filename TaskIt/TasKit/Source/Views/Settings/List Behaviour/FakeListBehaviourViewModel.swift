//
//  FakeListBehaviourViewModel.swift
//  TasKit
//
//  Created by Kyle Dold on 15/04/2021.
//

import Foundation

class FakeListBehaviourViewModel: ListBehaviourViewModelProtocol {
    
    var titleText = "List Behaviour"
    var showSubTasksText = "Some setting"
    var showSubTasksDescription = "Some setting description"
    var isShowSubTasksEnabled = true
    var showReminderText = "Show reminder"
    var showReminderDescription = "Show reminder description"
    var isReminderEnabled = true
    var moveIncompleteTasksText = "Move incomplete tasks"
    var moveIncompleteTasksDescription = "Move incomplete tasks description"
    var isMoveInompleteTasksEnabled = true
}
