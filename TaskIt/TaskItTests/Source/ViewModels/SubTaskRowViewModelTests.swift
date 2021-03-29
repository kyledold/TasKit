//
//  SubTaskRowViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 18/03/2021.
//

import XCTest
@testable import TaskIt

class SubTaskRowViewModelTests: XCTestCase {
    
    private static let mockPersistenceController = PersistenceController(inMemory: true)
    private lazy var mockTask = Task.StubFactory.make(title: "Mock task", persistenceController: Self.mockPersistenceController)
    private lazy var mockSubTask = SubTask.StubFactory.make(task: mockTask, title: "Mock sub-task", persistenceController: Self.mockPersistenceController)
    
    private lazy var sut = SubTaskRowViewModel(
        subTask: mockSubTask,
        onChangeCompletion: { _ in }
    )
    
    override class func tearDown() {
        mockPersistenceController.container.viewContext.rollback()
        super.tearDown()
    }
    
    // MARK: - Properties
    
    func test_whenIsCompleteCalled_thenReturnsFalse() {
        // given
        // when
        let result = sut.isComplete
        
        // then
        XCTAssertEqual(result, false)
    }
    
    func test_whenIdCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.id
        
        // then
        XCTAssertEqual(result, mockSubTask.id)
    }
    
    func test_whenTitleCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.title
        
        // then
        XCTAssertEqual(result, mockSubTask.title)
    }
    
    func test_givenOnChangeCompletionClosure_whenIsCompletedChanged_thenClosureCalledWithCorrectValue() {
        // given
        var completionResult = false
        sut.onChangeCompletion = { newValue in
            completionResult = newValue
        }
        
        // when
        sut.isComplete = true
        
        // then
        XCTAssertEqual(completionResult, true)
    }
}
