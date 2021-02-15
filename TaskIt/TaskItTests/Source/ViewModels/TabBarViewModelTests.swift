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
    
    func test_tasksText() {
        XCTAssertEqual(sut.tasksText, "Tasks")
    }
    
    func test_calendarText() {
        XCTAssertEqual(sut.calendarText, "Calendar")
    }
    
    func test_settingsText() {
        XCTAssertEqual(sut.settingsText, "Settings")
    }
}
