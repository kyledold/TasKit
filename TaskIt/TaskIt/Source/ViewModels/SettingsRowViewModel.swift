//
//  SettingsRowViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

import Foundation

class SettingsRowViewModel: SettingsRowViewModelProtocol {
    
    // MARK: - Properties
    
    var id: Int { return settingsItem.rawValue }
    
    var titleText: String {
        switch settingsItem {
        case .feedback: return NSLocalizedString("settings.feedback.title", comment: "feedback title")
        case .openSource: return NSLocalizedString("settings.open_source.title", comment: "open source title")
        }
    }

    var subtitleText: String {
        switch settingsItem {
        case .feedback: return NSLocalizedString("settings.feedback.subtitle", comment: "feedback subtitle")
        case .openSource: return NSLocalizedString("settings.open_source.subtitle", comment: "open source subtitle")
        }
    }

    var systemImageName: String {
        switch settingsItem {
        case .feedback: return "at"
        case .openSource: return "swift"
        }
    }
    
    var url: URL {
        switch settingsItem {
        case .feedback: return URL(string: "mailto:kdold02@gmail.com")!
        case .openSource: return URL(string: "https://github.com/kyledold/TaskIt")!
        }
    }
    
    private(set) var settingsItem: SettingsItem
    
    // MARK: - Initialisation
    
    init(settingItem: SettingsItem) {
        self.settingsItem = settingItem
    }
}
