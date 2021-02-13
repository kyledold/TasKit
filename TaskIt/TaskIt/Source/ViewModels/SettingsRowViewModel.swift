//
//  SettingsRowViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

import Foundation

class SettingsRowViewModel: SettingsRowViewModelProtocol {
    
    var id: Int { return settingsItem.rawValue }
    
    var titleTextKey: String {
        switch settingsItem {
        case .feedback: return "settings.feedback.title"
        case .openSource: return "settings.open_source.title"
        }
    }

    var subtitleTextKey: String {
        switch settingsItem {
        case .feedback: return "settings.feedback.subtitle"
        case .openSource: return "settings.open_source.subtitle"
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
    
    init(settingItem: SettingsItem) {
        self.settingsItem = settingItem
    }
}
