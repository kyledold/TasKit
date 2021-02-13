//
//  FakeSettingsViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

import Foundation

class FakeSettingsViewModel: SettingsViewModelProtocol {
    
    var titleTextKey = "settings.title"
    var versionNumber: String? = "1.0.0"
    var rowViewModels: [SettingsRowViewModel] = [
        SettingsRowViewModel(settingItem: .feedback),
        SettingsRowViewModel(settingItem: .openSource)
    ]
}
