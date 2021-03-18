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
    
    // MARK: - Properties
    
    func test_givenDefaultInit_whenIdCalled_thenValueEqualsExpectedValue() {
        // given
        // when
        let result = sut.id
        
        // then
        XCTAssertEqual(result, mockTask.id)
    }
    
    func test_givenDefaultInit_whenTaskTitleCalled_thenValueEqualsExpectedValue() {
        // given
        // when
        let result = sut.taskTitle
        
        // then
        XCTAssertEqual(result, mockTask.title)
    }
    
    func test_givenDefaultInit_whenIsCompleteCalled_thenValueEqualsExpectedValue() {
        // given
        // when
        let result = sut.isComplete
        
        // then
        XCTAssertEqual(result, mockTask.status == .completed)
    }
}
