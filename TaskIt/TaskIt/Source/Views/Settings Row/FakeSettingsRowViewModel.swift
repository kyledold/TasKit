//
//  FakeSettingsRowViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

import Foundation

class FakeSettingsRowViewModel: SettingsRowViewModelProtocol {
    
    var id = 0
    var titleText = "settings.feedback.title"
    var subtitleText = "settings.feedback.subtitle"
    var systemImageName = "at"
    var url = URL(string: "mailto:kdold02@gmail.com")!
    var settingsItem: SettingsItem = .feedback
}