//
//  ListBehaviourViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/04/2021.
//

import Foundation

class ListBehaviourViewModel: ListBehaviourViewModelProtocol {
    
    // MARK: - Properties
    
    let titleText = NSLocalizedString("settings.list_behaviour.title", comment: "title")
    let showSubTasksText = NSLocalizedString("settings.list_behaviour.show_sub_tasks.title", comment: "show sub-tasks text")
    let showSubTasksDescription = NSLocalizedString("settings.list_behaviour.show_sub_tasks.description", comment: "show sub-tasks description")
    
    var showReminderText = NSLocalizedString("settings.list_behaviour.show_reminder.title", comment: "show reminder text")
    var showReminderDescription = NSLocalizedString("settings.list_behaviour.show_reminder.description", comment: "show_reminder description")
    
    
    @Published var isShowSubTasksEnabled: Bool = false
    @Published var isReminderEnabled: Bool = false
}
