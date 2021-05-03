//
//  TasksListViewModelTests.swift
//  TasKitTests
//
//  Created by Kyle Dold on 15/02/2021.
//

import XCTest
@testable import TaskIt

class TasksListViewModelTests: XCTestCase {
    
    private let mockSelectedDate = Date()
    private let mockPersistantContainer = PersistenceController(inMemory: true)
    
    private lazy var sut = TasksListViewModel(
        selectedDate: mockSelectedDate,
        coordinator: TaskItCoordinator(),
        managedObjectContext: mockPersistantContainer.container.viewContext
    )
    
    // MARK: - Properties
    
    func test_whenSelectedDateCalled_thenValueEqualsCurrentDate() {
        // given
        // when
        let result = sut.selectedDate
        
        // then
        XCTAssertEqual(result, mockSelectedDate)
    }
    
    func test_whenSelectedDateTextCalled_thenValueEqualsToday() {
        // given
        // when
        let result = sut.selectedDateText
        
        // then
        XCTAssertEqual(result, "Today")
    }
    
    func test_whenShowNewTaskViewCalled_thenValueEqualsFalse() {
        // given
        // when
        let result = sut.showNewTaskView
        
        // then
        XCTAssertEqual(result, false)
    }
    
    func test_whenShowCalendarViewCalled_thenValueEqualsFalse() {
        // given
        // when
        let result = sut.showCalendarView
        
        // then
        XCTAssertEqual(result, false)
    }
    
    func test_whenShowSortButtonCalled_thenValueEqualsFalse() {
        // given
        // when
        let result = sut.showSortButton
        
        // then
        XCTAssertEqual(result, false)
    }
    
    func test_whenCreateTaskButtonTextCalled_thenReturnsExpectedString() {
        // given
        // when
        let result = sut.createTaskButtonText
        
        // then
        XCTAssertEqual(result, "Create task")
    }
    
    func test_whenEmptyListTextCalled_thenReturnsExpectedString() {
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
