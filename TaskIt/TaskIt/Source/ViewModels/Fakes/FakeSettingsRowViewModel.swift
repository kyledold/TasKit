//
//  FakeSettingsRowViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

import Foundation

class FakeSettingsRowViewModel: SettingsRowViewModelProtocol {
    
    var id = 0
    var titleTextKey = "settings.feedback.title"
    var subtitleTextKey = "settings.feedback.subtitle"
    var systemImageName = "at"
    var url = URL(string: "mailto:kdold02@gmail.com")!
    var settingsItem: SettingsItem = .feedback
}
