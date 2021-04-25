//
//  AppSettings.swift
//  TaskIt
//
//  Created by Kyle Dold on 25/04/2021.
//

import Foundation

enum AppSettings {
    
    enum key: String {
        case iCloudSync = "iCloudSync"
        case showSubTasks = "showSubTasks"
        case reminder = "Reminder"
        case moveInompleteTasks = "moveInompleteTasks"
    }
    
    static subscript(_ key: key) -> Any? {
        get { return UserDefaults.standard.value(forKey: key.rawValue) }
        set { UserDefaults.standard.setValue(newValue, forKey: key.rawValue) }
    }
    
    static func boolValue(_ key: key) -> Bool {
        if let value = AppSettings[key] as? Bool { return value }
        return false
    }
}
