//
//  SettingsViewModel.swift
//  TasKit
//
//  Created by Kyle Dold on 13/02/2021.
//

import Foundation

class SettingsViewModel: SettingsViewModelProtocol {
    
    // MARK: - Properties
    
    let titleText = NSLocalizedString("settings.title", comment: "title")
    var versionNumber = Bundle.version
    
    let listBehaviourText = NSLocalizedString("settings.list_behaviour.title", comment: "list behaviour title")
    let syncText = NSLocalizedString("settings.sync.title", comment: "sync title")
    
    let listBehaviourViewModel = ListBehaviourViewModel()
    let syncSettingsViewModel = SyncSettingsViewModel()
}
