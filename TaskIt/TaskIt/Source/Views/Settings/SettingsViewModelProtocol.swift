//
//  SettingsViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

protocol SettingsViewModelProtocol: Identifiable {
    
    var titleText: String { get }
    var versionNumber: String? { get }
    var preferencesViewModels: [SettingsRowViewModel] { get }
    var footerViewModels: [SettingsRowViewModel] { get }
}
