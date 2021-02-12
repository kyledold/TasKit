//
//  TaskItApp.swift
//  TaskIt
//
//  Created by Kyle Dold on 31/01/2021.
//

import SwiftUI

@main
struct TaskItApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabBarView(viewModel: TabBarViewModel())
        }
    }
}
