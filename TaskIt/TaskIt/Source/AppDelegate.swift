//
//  AppDelegate.swift
//  TaskIt
//
//  Created by Kyle Dold on 14/02/2021.
//

import UIKit
import NetworkKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        application.registerForRemoteNotifications()
        
        return true
    }
}
