//
//  MockTask.swift
//  TaskItTests
//
//  Created by Kyle Dold on 17/02/2021.
//

@testable import TaskIt
import Foundation

extension Task {
    
    enum StubFactory {
        
        static func make(
            title: String = "",
            isComplete: Bool = false,
            dueDate: Date = Date(),
            taskNotes: String = "",
            persistenceController: PersistenceController
        ) -> Task {
            let task = Task(context: persistenceController.container.viewContext)
            task.id = UUID()
            task.title = title
            task.isComplete = isComplete
            task.dueDate = dueDate
            task.notes = taskNotes
            return task
        }
    }
}
