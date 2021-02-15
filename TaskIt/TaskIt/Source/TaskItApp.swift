//
//  TaskItApp.swift
//  TaskIt
//
//  Created by Kyle Dold on 31/01/2021.
//

import SwiftUI
import NetworkKit

@main
struct TaskItApp: App {
    
    static let persistenceController = PersistenceController.shared
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            TabBarView(viewModel: TabBarViewModel())
                .environment(\.managedObjectContext, TaskItApp.persistenceController.container.viewContext)
        }
    }
}
