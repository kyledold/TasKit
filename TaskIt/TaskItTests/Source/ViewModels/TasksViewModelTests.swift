//
//  TasksViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 15/02/2021.
//

import XCTest
@testable import TaskIt

class TasksViewModelTests: XCTestCase {
    
    let mockManagedObjectContext = MockNSManagedObjectContext()
    private lazy var sut = TasksViewModel(managedObjectContext: mockManagedObjectContext)
    
    func test_titleText() {
        XCTAssertEqual(sut.titleText, "Tasks")
    }
}
