//
//  TaskDetailsViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 18/03/2021.
//

import XCTest
@testable import TaskIt

class TaskDetailsViewModelTests: XCTestCase {
    
    private lazy var mockTask = Task.StubFactory.make(title: "Mock task", persistenceController: mockPersistenceController)
    private let mockPersistenceController = PersistenceController(inMemory: true)
    
    private lazy var sut = TaskDetailsViewModel(
        task: mockTask,
        onDateChanged: {},
        managedObjectContext: mockPersistenceController.container.viewContext
    )
    
    // MARK: - Properties
    
    func test_givenInit_whenTaskNameCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.taskName
        
        // then
        XCTAssertEqual(result, mockTask.title)
    }
    
    func test_givenInit_whenDueDateCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.dueDate
        
        // then
        XCTAssertEqual(result, mockTask.dueDate)
    }
    
    func test_givenInit_whenIsCompleteCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.isComplete
        
        // then
        XCTAssertEqual(result, mockTask.isComplete)
    }
    
    func test_givenInit_whenTaskNotesCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.taskNotes
        
        // then
        XCTAssertEqual(result, mockTask.notes)
    }
    
    func test_givenInit_whenTaskNamePlaceholderTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.taskNamePlaceholderText
        
        // then
        XCTAssertEqual(result, "Task name")
    }
    
    func test_givenInit_whenTaskNotesPlaceholderTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.taskNotesPlaceholderText
        
        // then
        XCTAssertEqual(result, "Write any notes here...")
    }
    
    func test_givenInit_whenTaskDateTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.taskDateText
        
        // then
        XCTAssertEqual(result, "Date")
    }
    
    func test_givenInit_whenDeleteAlertTitleTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.deleteAlertTitleText
        
        // then
        XCTAssertEqual(result, "Delete task")
    }
    
    func test_givenInit_whenDeleteAlertMessageTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.deleteAlertMessageText
        
        // then
        XCTAssertEqual(result, "Are you sure you want to delete this task?")
    }
    
    func test_givenInit_whenDeleteButtonTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.deleteButtonText
        
        // then
        XCTAssertEqual(result, "Delete")
    }
}
