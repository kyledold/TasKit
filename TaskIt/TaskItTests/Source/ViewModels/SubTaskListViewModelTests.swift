//
//  SubTaskListViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 18/03/2021.
//

import XCTest
@testable import TaskIt

class SubTaskListViewModelTests: XCTestCase {
    
    private let mockPersistenceController = PersistenceController(inMemory: true)
    private lazy var mockTask = Task.StubFactory.make(title: "Mock task", persistenceController: mockPersistenceController)
    private let mockPersistantContainer = PersistenceController(inMemory: true)
    
    private lazy var sut = SubTaskListViewModel(
        task: mockTask,
        managedObjectContext: mockPersistantContainer.container.viewContext
    )
    
    // MARK: - Properties
    
    func test_givenInit_whenNewSubTaskNameCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.newSubTaskName
        
        // then
        XCTAssertEqual(result, "")
    }
    
    func test_givenInit_whenIsListInEditModeCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.isListInEditMode
        
        // then
        XCTAssertEqual(result, false)
    }
    
    func test_givenInit_whenHeaderTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.headerText
        
        // then
        XCTAssertEqual(result, "Sub-tasks")
    }
    
    func test_givenInit_whenSubTaskNamePlaceholderTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.subTaskNamePlaceholderText
        
        // then
        XCTAssertEqual(result, "Enter sub-task name here...")
    }
    
    func test_givenInit_whenAddSubTaskButtonTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.addSubTaskButtonText
        
        // then
        XCTAssertEqual(result, "Add a sub-task")
    }
    
    func test_givenInit_whenAddButtonTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.addButtonText
        
        // then
        XCTAssertEqual(result, "Add")
    }
    
    func test_givenInit_whenCancelButtonTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.cancelButtonText
        
        // then
        XCTAssertEqual(result, "Cancel")
    }
    
    func test_givenInit_whenDoneButtonTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.doneButtonText
        
        // then
        XCTAssertEqual(result, "Done")
    }
    
    func test_givenInit_whenEditButtonTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.editButtonText
        
        // then
        XCTAssertEqual(result, "Edit")
    }
}
