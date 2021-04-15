//
//  FakeSettingsViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

class FakeSettingsViewModel: SettingsViewModelProtocol {
    
    var titleText = "Settings"
    var versionNumber: String? = "1.0.0"
    let listBehaviourText = "List Behaviour"
    let syncText = "Sync"
    let listBehaviourViewModel = ListBehaviourViewModel()
}
