//
//  TaskDetailsViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 18/03/2021.
//

import XCTest
@testable import TaskIt

class TaskDetailsViewModelTests: XCTestCase {
    
    private let mockTask = Task.StubFactory.make(title: "Mock task")
    private lazy var sut = TaskDetailsViewModel(
        task: mockTask,
        managedObjectContext: MockNSManagedObjectContext()
    )
    
    // MARK: - Properties
    
    func test_givenDefaultInit_whenTaskNameCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.taskName
        
        // then
        XCTAssertEqual(result, mockTask.title)
    }
    
    func test_givenDefaultInit_whenDueDateCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.dueDate
        
        // then
        XCTAssertEqual(result, mockTask.dueDate)
    }
    
    func test_givenDefaultInit_whenIsCompleteCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.isComplete
        
        // then
        XCTAssertEqual(result, mockTask.isComplete)
    }
    
    func test_givenDefaultInit_whenTaskNotesCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.taskNotes
        
        // then
        XCTAssertEqual(result, mockTask.notes)
    }
    
    func test_givenDefaultInit_whenTaskNamePlaceholderTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.taskNamePlaceholderText
        
        // then
        XCTAssertEqual(result, "Task name")
    }
    
    func test_givenDefaultInit_whenTaskNotesPlaceholderTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.taskNotesPlaceholderText
        
        // then
        XCTAssertEqual(result, "Write any notes here...")
    }
    
    func test_givenDefaultInit_whenTaskDateTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.taskDateText
        
        // then
        XCTAssertEqual(result, "Date")
    }
    
    func test_givenDefaultInit_whenDeleteAlertTitleTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.deleteAlertTitleText
        
        // then
        XCTAssertEqual(result, "Delete task")
    }
    
    func test_givenDefaultInit_whenDeleteAlertMessageTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.deleteAlertMessageText
        
        // then
        XCTAssertEqual(result, "Are you sure you want to delete this task?")
    }
    
    func test_givenDefaultInit_whenDeleteButtonTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.deleteButtonText
        
        // then
        XCTAssertEqual(result, "Delete")
    }
}
