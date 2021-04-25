//
//  ListBehaviourViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/04/2021.
//

import Combine
import Foundation

class ListBehaviourViewModel: ListBehaviourViewModelProtocol {
    
    // MARK: - Properties
    
    let titleText = NSLocalizedString("settings.list_behaviour.title", comment: "title")
    let showSubTasksText = NSLocalizedString("settings.list_behaviour.show_sub_tasks.title", comment: "show sub-tasks text")
    let showSubTasksDescription = NSLocalizedString("settings.list_behaviour.show_sub_tasks.description", comment: "show sub-tasks description")
    
    var showReminderText = NSLocalizedString("settings.list_behaviour.show_reminder.title", comment: "show reminder text")
    var showReminderDescription = NSLocalizedString("settings.list_behaviour.show_reminder.description", comment: "show_reminder description")
    
    var moveIncompleteTasksText = NSLocalizedString("settings.list_behaviour.move_incomplete_tasks.title", comment: "move incomplete tasks text")
    var moveIncompleteTasksDescription = NSLocalizedString("settings.list_behaviour.move_incomplete_tasks.description", comment: "move incomplete tasks description")
    
    @Published var isShowSubTasksEnabled: Bool
    @Published var isReminderEnabled: Bool
    @Published var isMoveInompleteTasksEnabled: Bool
    
    private var subscribers: Set<AnyCancellable> = []
    
    // MARK: - Initialisation
    
    init() {
        isShowSubTasksEnabled = AppSettings.boolValue(.showSubTasks)
        isReminderEnabled = AppSettings.boolValue(.reminder)
        isMoveInompleteTasksEnabled = AppSettings.boolValue(.moveInompleteTasks)
         
        addObservers()
    }
    
    // MARK: - Observers
    
    private func addObservers() {
        
        $isShowSubTasksEnabled.dropFirst().sink { newValue in
            AppSettings[.showSubTasks] = newValue
        }.store(in: &subscribers)
        
        $isReminderEnabled.dropFirst().sink { newValue in
            AppSettings[.reminder] = newValue
        }.store(in: &subscribers)
        
        $isMoveInompleteTasksEnabled.dropFirst().sink { newValue in
            AppSettings[.moveInompleteTasks] = newValue
        }.store(in: &subscribers)
    }
}
