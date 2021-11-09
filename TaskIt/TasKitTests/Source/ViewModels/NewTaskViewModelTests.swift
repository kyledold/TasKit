//
//  NewTaskViewModelTests.swift
//  TasKitTests
//
//  Created by Kyle Dold on 18/03/2021.
//

import XCTest
@testable import TaskIt

class NewTaskViewModelTests: XCTestCase {
    
    private let mockSelectedDate = Date()
    private let mockIndex = 2
    private static let mockPersistenceController = PersistenceController(inMemory: true)
    
    private lazy var sut = NewTaskViewModel(
        selectedDate: mockSelectedDate,
        index: mockIndex,
        managedObjectContext: Self.mockPersistenceController.container.viewContext
    )
    
    override class func tearDown() {
        mockPersistenceController.container.viewContext.rollback()
        super.tearDown()
    }
    
    func test_whenSelectedDateCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.selectedDate
        
        // then
        XCTAssertEqual(result, mockSelectedDate)
    }
    
    func test_whenTaskNameCalled_thenReturnsEmptyString() {
        // given
        // when
        let result = sut.taskName
        
        // then
        XCTAssertEqual(result, "")
    }
    
    func test_whenTaskNamePlaceholderCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.taskNamePlaceholder
        
        // then
        XCTAssertEqual(result, "Type new task name here...")
    }
    
    func test_givenEmptyTaskName_whenIsCreateButtonDisabledCalled_thenReturnsTrue() {
        // given
        // when
        let result = sut.isCreateButtonDisabled
        
        // then
        XCTAssertEqual(result, true)
    }
    
    func test_givenTaskNameEntered_whenIsCreateButtonDisabledCalled_thenReturnsFalse() {
        // given
        sut.taskName = "test name entry"
        
        // when
        let result = sut.isCreateButtonDisabled
        
        // then
        XCTAssertEqual(result, false)
    }
    
    func test_givenTaskNameEntered_whenCreateButtonTapped_thenTaskIsCreated() {
        // given
        var taskAddedCalled = 0
        let taskName = "test name entry"
        sut.taskName = taskName
        sut.onTaskAdded = {
            taskAddedCalled += 1
        }
        
        // when
        sut.createTaskButtonTapped { }
        
        // then
        let result = Task.fetchAll(for: mockSelectedDate, viewContext: Self.mockPersistenceController.container.viewContext).first
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.title, taskName)
        XCTAssertEqual(result?.dueDate, mockSelectedDate)
        XCTAssertEqual(result?.index, Int16(mockIndex))
        XCTAssertEqual(taskAddedCalled, 1)
    }
}
