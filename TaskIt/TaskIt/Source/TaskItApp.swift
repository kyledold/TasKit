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
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TabBarView(viewModel: TabBarViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
