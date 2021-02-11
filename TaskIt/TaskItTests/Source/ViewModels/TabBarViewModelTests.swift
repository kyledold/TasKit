//
//  TabBarViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 11/02/2021.
//

import XCTest
@testable import TaskIt

class TabBarViewModelTests: XCTestCase {
    
    private lazy var sut = TabBarViewModel()
    
    func test_tasksTextKey() {
        XCTAssertEqual(sut.tasksTextKey, "tab_bar.tasks")
    }
    
    func test_calendarTextKey() {
        XCTAssertEqual(sut.calendarTextKey, "tab_bar.calendar")
    }
}
