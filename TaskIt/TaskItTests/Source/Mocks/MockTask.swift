//
//  MockTask.swift
//  TaskItTests
//
//  Created by Kyle Dold on 17/02/2021.
//

@testable import TaskIt

extension Task {
    
    enum StubFactory {
        
        static func make(
            title: String = "",
            priority: Priority = .none,
            status: Status = .todo,
            dueDate: Date = Date()
        ) -> Task {
            let task = Task(context: MockNSManagedObjectContext())
            task.title = title
            task.priority = priority
            task.status = status
            task.dueDate = dueDate
            return task
        }
    }
}
