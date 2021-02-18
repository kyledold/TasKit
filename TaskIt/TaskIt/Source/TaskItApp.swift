//
//  TaskItApp.swift
//  TaskIt
//
//  Created by Kyle Dold on 31/01/2021.
//

import SwiftUI
import PartialSheet

@main
struct TaskItApp: App {
    
    let persistenceController = PersistenceController.shared
    let sheetManager = PartialSheetManager()
    
    var body: some Scene {
        WindowGroup {
            TabBarView(viewModel: TabBarViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(sheetManager)
        }
    }
}
