//
//  SettingsViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

import Foundation

class SettingsViewModel: SettingsViewModelProtocol {
    
    // MARK: - Properties
    
    let titleText = NSLocalizedString("settings.title", comment: "title")
    var versionNumber = Bundle.version
    
    private(set) var rowViewModels: [SettingsRowViewModel] = [
        SettingsRowViewModel(settingItem: .feedback),
        SettingsRowViewModel(settingItem: .openSource)
    ]
}

enum SettingsItem: Int {
    case feedback
    case openSource
}
