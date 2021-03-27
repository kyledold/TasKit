//
//  TaskRowViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 17/02/2021.
//

import XCTest
@testable import TaskIt

class TaskRowViewModelTests: XCTestCase {
    
    private let mockPersistenceController = PersistenceController(inMemory: true)
    private lazy var mockTask = Task.StubFactory.make(title: "Mock task", persistenceController: mockPersistenceController)
    private let mockPersistantContainer = PersistenceController(inMemory: true)
    
    private lazy var sut = TaskRowViewModel(
        task: mockTask,
        managedObjectContext: mockPersistantContainer.container.viewContext,
        onChangeCompletion: { _ in }
    )
    
    // MARK: - Properties
    
    func test_givenInit_whenIdCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.id
        
        // then
        XCTAssertEqual(result, mockTask.id)
    }
    
    func test_givenInit_whenTitleCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.title
        
        // then
        XCTAssertEqual(result, mockTask.title)
    }
    
    func test_givenInit_whenIsCompleteCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.isComplete
        
        // then
        XCTAssertEqual(result, mockTask.isComplete)
    }
    
    func test_givenTaskWithoutDueTime_whenTimeCalled_thenReturnsNil() {
        // given
        // when
        let result = sut.time
        
        // then
        XCTAssertNil(result)
    }
    
    func test_givenTaskWithDueTime_whenTimeCalled_thenReturnsExpectedValue() {
        // given
        let mockDueTime = Date().setTime(hour: 10, minute: 15)
        let mockTask = Task.StubFactory.make(title: "Mock task", dueTime: mockDueTime, persistenceController: mockPersistenceController)
        let sut = TaskRowViewModel(
            task: mockTask,
            managedObjectContext: mockPersistantContainer.container.viewContext,
            onChangeCompletion: { _ in }
        )
        
        // when
        let result = sut.time
        
        // then
        XCTAssertEqual(result, mockDueTime.shortTime)
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
