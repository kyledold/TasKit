//
//  SettingsViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 13/02/2021.
//

import XCTest
@testable import TaskIt

class SettingsViewModelTests: XCTestCase {
    
    private lazy var sut = SettingsViewModel()
    
    func test_givenInit_whenTitleTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.titleText
        
        // then
        XCTAssertEqual(result, "Settings")
    }
    
    func test_givenInit_whenVersionNumberCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.versionNumber
        
        // then
        XCTAssertEqual(result, Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)
    }
    
    func test_givenInit_whenRowViewModelsCalled_thenReturnsExpectedValues() {
        // given
        // when
        let result = sut.rowViewModels
        
        // then
        XCTAssertEqual(result.count, 2)
        
        let feedbackRowViewModel = result[0]
        XCTAssertNotNil(feedbackRowViewModel)
        XCTAssertEqual(feedbackRowViewModel.settingsItem, .feedback)
        
        let openSourceRowViewModel = result[1]
        XCTAssertNotNil(openSourceRowViewModel)
        XCTAssertEqual(openSourceRowViewModel.settingsItem, .openSource)
    }
}
