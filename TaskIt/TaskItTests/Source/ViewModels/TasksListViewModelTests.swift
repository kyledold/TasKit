//
//  TasksListViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 15/02/2021.
//

import XCTest
@testable import TaskIt

class TasksListViewModelTests: XCTestCase {
    
    let mockManagedObjectContext = MockNSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    private lazy var sut = TasksListViewModel(
        coordinator: TaskItCoordinator(),
        managedObjectContext: MockNSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    )
    
    func test_givenDefaultInit_whenSelectedDateCalled_thenValueEqualsCurrentDate() {
        // given
        // when
        let result = sut.selectedDate
        
        // then
        XCTAssertEqual(result, Date())
    }
    
    func test_givenDefaultInit_whenSelectedDateTextCalled_thenValueEqualsToday() {
        // given
        // when
        let result = sut.selectedDateText
        
        // then
        XCTAssertEqual(result, "Today")
    }
}
