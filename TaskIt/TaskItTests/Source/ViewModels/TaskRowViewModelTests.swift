//
//  TaskRowViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 17/02/2021.
//

import XCTest
@testable import TaskIt

class TaskRowViewModelTests: XCTestCase {
    
    private let mockTask = Task.StubFactory.make(title: "Mock task", priority: .medium)
    private lazy var sut = TaskRowViewModel(task: mockTask)
    
    func test_titleText() {
        XCTAssertEqual(sut.titleText, mockTask.title)
    }
    
    func test_priority() {
        XCTAssertEqual(sut.priority, mockTask.priority)
    }
}
