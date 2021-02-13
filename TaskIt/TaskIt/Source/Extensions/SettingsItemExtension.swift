//
//  SettingItemExtension.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

import SwiftUI

extension SettingsItem {
    
    var color: Color {
        switch self {
        case .feedback: return .green
        case .openSource: return .orange
        }
    }
}
