//
//  MockSubTask.swift
//  TaskItTests
//
//  Created by Kyle Dold on 18/03/2021.
//

@testable import TaskIt
import Foundation

extension SubTask {

    enum StubFactory {
        
        static func make(
            task: Task,
            title: String = "",
            isComplete: Bool = false,
            persistenceController: PersistenceController
        ) -> SubTask {
            let subTask = SubTask(context: persistenceController.container.viewContext)
            subTask.task = task
            subTask.id = UUID()
            subTask.title = title
            subTask.isComplete = isComplete
            return subTask
        }
    }
}
