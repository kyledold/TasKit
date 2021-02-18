//
//  MockTask.swift
//  TaskItTests
//
//  Created by Kyle Dold on 17/02/2021.
//

@testable import TaskIt

class MockTask: Task {
    
    convenience init(
        title: String = "",
        priority: Priority = .none,
        status: Status = .todo
    ) {
        self.init()
        self.title = title
        self.priority = priority
        self.status = status
    }
}
