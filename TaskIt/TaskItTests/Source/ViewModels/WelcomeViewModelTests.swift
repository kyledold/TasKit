//
//  WelcomeViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 11/02/2021.
//

import XCTest
@testable import TaskIt

class WelcomeViewModelTests: XCTestCase {
    
    private lazy var sut = WelcomeViewModel()
    
    func test_welcomeTextKey() {
        XCTAssertEqual(sut.welcomeTextKey, "welcome.welcome")
    }
    
    func test_getStartedButtonTextKey() {
        XCTAssertEqual(sut.gotItButtonTextKey, "welcome.got_it")
    }
    
    func test_disclaimerTextKey() {
        XCTAssertEqual(sut.disclaimerTextKey, "welcome.terms_and_conditions")
    }
}
