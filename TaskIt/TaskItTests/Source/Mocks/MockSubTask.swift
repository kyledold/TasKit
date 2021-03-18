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
            isComplete: Bool = false
        ) -> SubTask {
            let subTask = SubTask(context: MockNSManagedObjectContext())
            subTask.task = task
            subTask.id = UUID()
            subTask.title = title
            subTask.isComplete = isComplete
            return subTask
        }
    }
}
