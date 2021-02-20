//
//  TaskItApp.swift
//  TaskIt
//
//  Created by Kyle Dold on 31/01/2021.
//

import SwiftUI

@main
struct TaskItApp: App {
    
    let viewContext = PersistenceController.shared.container.viewContext
    
    var body: some Scene {
        WindowGroup {
            TasksView(viewModel: TasksViewModel(managedObjectContext: viewContext))
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
