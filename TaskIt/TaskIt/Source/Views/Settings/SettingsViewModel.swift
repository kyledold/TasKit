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
    
    private(set) var preferencesViewModels: [SettingsRowViewModel] = []
    private(set) var footerViewModels: [SettingsRowViewModel] = []
    
    // MARK: - Initialisation
    
    init() {
        self.preferencesViewModels = makePreferenceRowViewModels()
        self.footerViewModels = makeFooterRowViewModels()
    }
    
    // MARK: - Make Row Viewmodels
    
    private func makePreferenceRowViewModels() -> [SettingsRowViewModel] {
        return [
            SettingsRowViewModel(
                settingsItem: .listBehaviour,
                title: NSLocalizedString("settings.list_behaviour.title", comment: "list behaviour title"),
                subtitle: NSLocalizedString("settings.list_behaviour.subtitle", comment: "list behaviour subtitle")
            ),
            SettingsRowViewModel(
                settingsItem: .sync,
                title: NSLocalizedString("settings.sync.title", comment: "sync title"),
                subtitle: NSLocalizedString("settings.sync.subtitle", comment: "sync subtitle")
            )
        ]
    }
    
    private func makeFooterRowViewModels() -> [SettingsRowViewModel] {
        return [
            SettingsRowViewModel(
                settingsItem: .openSource,
                title: NSLocalizedString("settings.open_source.title", comment: "open source title"),
                subtitle: NSLocalizedString("settings.open_source.subtitle", comment: "open source subtitle")
            )
        ]
    }
}

enum SettingsItem: Int {
    case listBehaviour
    case sync
    case openSource
}
