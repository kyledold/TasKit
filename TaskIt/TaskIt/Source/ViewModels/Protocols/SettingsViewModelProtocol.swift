//
//  SettingsViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

import Foundation

protocol SettingsViewModelProtocol {
    
    var titleTextKey: String { get }
    var versionNumber: String? { get }
    var rowViewModels: [SettingsRowViewModel] { get }
}
