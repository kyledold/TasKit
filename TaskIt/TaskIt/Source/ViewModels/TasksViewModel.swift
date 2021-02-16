//
//  TasksViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 14/02/2021.
//

import CoreData
import Foundation
import NetworkKit

class TasksViewModel: TasksViewModelProtocol {
    
    let titleText = NSLocalizedString("tasks.title", comment: "Tasks title")
    @Published var tasks: [Task] = []
    
    private let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func fetchTasks() {
        tasks = Task.fetchAll(viewContext: managedObjectContext)
    }
}
