//
//  NewTaskViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 18/03/2021.
//

import XCTest
@testable import TaskIt

class NewTaskViewModelTests: XCTestCase {
    
    private let mockSelectedDate = Date()
    private lazy var sut = NewTaskViewModel(
        selectedDate: mockSelectedDate,
        managedObjectContext: MockNSManagedObjectContext()
    )
    
    // MARK: - Properties
    
    func test_givenDefaultInit_whenSelectedDateCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.selectedDate
        
        // then
        XCTAssertEqual(result, mockSelectedDate)
    }
    
    func test_givenDefaultInit_whenTaskNameCalled_thenReturnsEmptyString() {
        // given
        // when
        let result = sut.taskName
        
        // then
        XCTAssertEqual(result, "")
    }
    
    func test_givenDefaultInit_whenTaskNamePlaceholderCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.taskNamePlaceholder
        
        // then
        XCTAssertEqual(result, "Type new task name here...")
    }
    
    func test_givenDefaultInit_whenIsCreateButtonDisabledCalled_thenReturnsTrue() {
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
}
