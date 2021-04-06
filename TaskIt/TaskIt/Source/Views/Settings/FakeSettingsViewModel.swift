//
//  FakeSettingsViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

class FakeSettingsViewModel: SettingsViewModelProtocol {
    
    var titleText = "Settings"
    var versionNumber: String? = "1.0.0"
    var preferencesViewModels: [SettingsRowViewModel] = [
        SettingsRowViewModel(
            settingsItem: .listBehaviour,
            title: "",
            subtitle: ""
        ),
        SettingsRowViewModel(
            settingsItem: .sync,
            title: "",
            subtitle: ""
        )
    ]
    
    var footerViewModels: [SettingsRowViewModel] = [
        SettingsRowViewModel(
            settingsItem: .openSource,
            title: "",
            subtitle: ""
        )
    ]
}
