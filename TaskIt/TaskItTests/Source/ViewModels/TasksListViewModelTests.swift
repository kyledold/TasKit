//
//  TasksListViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 15/02/2021.
//

import XCTest
@testable import TaskIt

class TasksListViewModelTests: XCTestCase {
    
    private let mockSelectedDate = Date()
    private let mockManagedObjectContext = MockNSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    private lazy var sut = TasksListViewModel(
        selectedDate: mockSelectedDate,
        coordinator: TaskItCoordinator(),
        managedObjectContext: mockManagedObjectContext
    )
    
    // MARK: - Properties
    
    func test_givenDefaultInit_whenSelectedDateCalled_thenValueEqualsCurrentDate() {
        // given
        // when
        let result = sut.selectedDate
        
        // then
        XCTAssertEqual(result, mockSelectedDate)
    }
    
    func test_givenDefaultInit_whenSelectedDateTextCalled_thenValueEqualsToday() {
        // given
        // when
        let result = sut.selectedDateText
        
        // then
        XCTAssertEqual(result, "Today")
    }
    
    func test_givenDefaultInit_whenShowNewTaskViewCalled_thenValueEqualsFalse() {
        // given
        // when
        let result = sut.showNewTaskView
        
        // then
        XCTAssertEqual(result, false)
    }
    
    func test_givenDefaultInit_whenShowCalendarViewCalled_thenValueEqualsFalse() {
        // given
        // when
        let result = sut.showCalendarView
        
        // then
        XCTAssertEqual(result, false)
    }
    
    func test_givenDefaultInit_whenShowSortButtonCalled_thenValueEqualsFalse() {
        // given
        // when
        let result = sut.showSortButton
        
        // then
        XCTAssertEqual(result, false)
    }
    
    func test_givenDefaultInit_whenCreateTaskButtonTextCalled_thenReturnsExpectedString() {
        // given
        // when
        let result = sut.createTaskButtonText
        
        // then
        XCTAssertEqual(result, "Create task")
    }
    
    func test_givenDefaultInit_whenEmptyListTextCalled_thenReturnsExpectedString() {
        // given
        // when
        let result = sut.emptyListText
        
        // then
        XCTAssertEqual(result, "No tasks")
    }
    
    // MARK: - Events
    
    func test_whenCreateTaskButtonTapped_thenShowNewTaskViewIsTrue() {
        // given
        // when
        sut.createTaskButtonTapped()
        let result = sut.showNewTaskView
        
        // then
        XCTAssertEqual(result, true)
    }
}
