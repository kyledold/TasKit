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
    
    func test_titleText() {
        XCTAssertEqual(sut.titleText, "Settings")
    }
    
    func test_versionNumber() {
        XCTAssertEqual(sut.versionNumber, Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)
    }
    
    func test_rowViewModels() {
        XCTAssertEqual(sut.rowViewModels.count, 2)
        
        let feedbackRowViewModel = sut.rowViewModels[0]
        XCTAssertNotNil(feedbackRowViewModel)
        XCTAssertEqual(feedbackRowViewModel.settingsItem, .feedback)
        
        let openSourceRowViewModel = sut.rowViewModels[1]
        XCTAssertNotNil(openSourceRowViewModel)
        XCTAssertEqual(openSourceRowViewModel.settingsItem, .openSource)
    }
}
