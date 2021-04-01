//
//  MockSubTask.swift
//  TaskItTests
//
//  Created by Kyle Dold on 18/03/2021.
//

import Foundation
import CoreData
@testable import TaskIt

extension SubTask {

    enum StubFactory {
        
        @discardableResult
        static func make(
            task: Task,
            title: String = "",
            index: Int = 0,
            isComplete: Bool = false,
            persistenceController: PersistenceController
        ) -> SubTask {
            
            let subTask = NSEntityDescription.insertNewObject(
                forEntityName: "SubTask",
                into: persistenceController.container.viewContext
            ) as! SubTask

            subTask.task = task
            subTask.id = UUID()
            subTask.index = Int16(index)
            subTask.title = title
            subTask.isComplete = isComplete
            
            return subTask
        }
    }
}
