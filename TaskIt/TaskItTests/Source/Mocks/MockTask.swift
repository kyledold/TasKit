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
            status: Status = .todo,
            dueDate: Date = Date(),
            taskNotes: String = ""
        ) -> Task {
            let task = Task(context: MockNSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
            task.title = title
            task.status = status
            task.dueDate = dueDate
            task.notes = taskNotes
            return task
        }
    }
}
