//
//  MockTask.swift
//  TasKitTests
//
//  Created by Kyle Dold on 17/02/2021.
//

import Foundation
import CoreData
@testable import TaskIt

extension Task {
    
    enum StubFactory {
        
        static func make(
            title: String = "",
            isComplete: Bool = false,
            dueDate: Date = Date(),
            dueTime: Date? = nil,
            taskNotes: String = "",
            isReminderSet: Bool = false,
            persistenceController: PersistenceController
        ) -> Task {
            
            let task = NSEntityDescription.insertNewObject(
                forEntityName: "Task",
                into: persistenceController.container.viewContext
            ) as! Task
            
            task.id = UUID()
            task.title = title
            task.isComplete = isComplete
            task.dueDate = dueDate
            task.dueTime = dueTime
            task.notes = taskNotes
            task.isReminderSet = isReminderSet
            
            return task
        }
    }
}
