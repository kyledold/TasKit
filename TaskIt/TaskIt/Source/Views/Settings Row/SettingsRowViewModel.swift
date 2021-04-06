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
    var titleText: String
    var subtitleText: String
    
    private(set) var settingsItem: SettingsItem
    
    // MARK: - Initialisation
    
    init(settingsItem: SettingsItem, title: String, subtitle: String) {
        self.settingsItem = settingsItem
        self.titleText = title
        self.subtitleText = subtitle
    }
}
