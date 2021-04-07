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
    
    private(set) var preferencesViewModels: [SettingsItem] = [.listBehaviour, .sync]
    private(set) var footerViewModels: [SettingsItem] = [.openSource]
}

enum SettingsItem: Int {
    case listBehaviour
    case sync
    case openSource
    
    var text: String {
        switch self {
        case .listBehaviour: return NSLocalizedString("settings.list_behaviour.title", comment: "list behaviour title")
        case .sync: return NSLocalizedString("settings.sync.title", comment: "sync title")
        case .openSource: return NSLocalizedString("settings.open_source.title", comment: "open source title")
        }
    }
}
