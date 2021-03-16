//
//  TaskRowViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 17/02/2021.
//

import XCTest
@testable import TaskIt

class TaskRowViewModelTests: XCTestCase {
    
    private let mockTask = Task.StubFactory.make(title: "Mock task")
    private lazy var sut = TaskRowViewModel(
        task: mockTask,
        managedObjectContext: MockNSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType),
        onChangeCompletion: { _ in }
    )
    
    func test_titleText() {
        //XCTAssertEqual(sut.titleText, mockTask.title)
    }
}
