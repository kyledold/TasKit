//
//  SettingsRowViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

import Foundation

protocol SettingsRowViewModelProtocol {
    
    var id: Int { get }
    var titleText: String { get }
    var subtitleText: String { get }
    var settingsItem: SettingsItem { get }
}
