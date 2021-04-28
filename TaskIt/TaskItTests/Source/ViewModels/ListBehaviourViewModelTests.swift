//
//  ListBehaviourViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 28/04/2021.
//

import XCTest
@testable import TaskIt

class ListBehaviourViewModelTests: XCTestCase {
    
    private lazy var sut = ListBehaviourViewModel()
    
    // MARK: - Properties
    
    func test_whenTitleTextCalled_thenReturnsExpectedString() {
        // given
        // when
        let result = sut.titleText
        
        // then
        XCTAssertEqual(result, "List Behaviour")
    }
    
    func test_whenShowSubTasksTextCalled_thenReturnsExpectedString() {
        // given
        // when
        let result = sut.showSubTasksText
        
        // then
        XCTAssertEqual(result, "Show Sub-tasks")
    }
    
    func test_whenShowSubTasksDescriptionCalled_thenReturnsExpectedString() {
        // given
        // when
        let result = sut.showSubTasksDescription
        
        // then
        XCTAssertEqual(result, "If enabled this will show the sub tasks under the related task in the list up to a maximum of 8.")
    }
    
    func test_whenShowReminderTextCalled_thenReturnsExpectedString() {
        // given
        // when
        let result = sut.showReminderText
        
        // then
        XCTAssertEqual(result, "Show Reminders")
    }
    
    func test_whenShowReminderDescriptionCalled_thenReturnsExpectedString() {
        // given
        // when
        let result = sut.showReminderDescription
        
        // then
        XCTAssertEqual(result, "If enabled this will show the reminder time next to the task name in the list.")
    }
    
    func test_whenMoveIncompleteTasksTextCalled_thenReturnsExpectedString() {
        // given
        // when
        let result = sut.moveIncompleteTasksText
        
        // then
        XCTAssertEqual(result, "Carry forward incomplete tasks")
    }
    
    func test_whenMoveIncompleteTasksDescriptionCalled_thenReturnsExpectedString() {
        // given
        // when
        let result = sut.moveIncompleteTasksDescription
        
        // then
        XCTAssertEqual(result, "If enabled this will carry forward any uncompleted tasks to the current date.")
    }
}

