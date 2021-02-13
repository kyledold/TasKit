//
//  SettingsRowViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

import Foundation

protocol SettingsRowViewModelProtocol {
    
    var id: Int { get }
    var titleTextKey: String { get }
    var subtitleTextKey: String { get }
    var systemImageName: String { get }
    var url: URL { get }
    var settingsItem: SettingsItem { get }
}
