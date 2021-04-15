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
    let showSubTasksText = NSLocalizedString("settings.list_behaviour.show_sub_tasks", comment: "show sub-tasks text")
    let showSubTasksDescription = NSLocalizedString("settings.list_behaviour.show_sub_tasks.description", comment: "show sub-tasks description")
    
    @Published var isShowSubTasksEnabled: Bool = false
}
