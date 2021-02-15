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
    
    func test_welcomeText() {
        XCTAssertEqual(sut.welcomeText, "Welcome")
    }
    
    func test_getStartedButtonText() {
        XCTAssertEqual(sut.gotItButtonText, "Got it")
    }
    
    func test_disclaimerText() {
        XCTAssertEqual(sut.disclaimerText, "By continuing you agree to Task Its Terms of Service and Privacy Policy")
    }
}
