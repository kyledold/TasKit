//
//  SettingsRowViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 13/02/2021.
//

import XCTest
@testable import TaskIt

class SettingsRowViewModelTests: XCTestCase {
    
    func test_feedbackRow_titleText() {
        let sut = SettingsRowViewModel(settingItem: .feedback)
        XCTAssertEqual(sut.titleText, "Feedback")
    }
    
    func test_feedbackRow_subtitleText() {
        let sut = SettingsRowViewModel(settingItem: .feedback)
        XCTAssertEqual(sut.subtitleText, "kdold02@gmail.com")
    }
    
    func test_feedbackRow_systemImageName() {
        let sut = SettingsRowViewModel(settingItem: .feedback)
        XCTAssertEqual(sut.systemImageName, "at")
    }
    
    func test_feedbackRow_url() {
        let sut = SettingsRowViewModel(settingItem: .feedback)
        XCTAssertEqual(sut.url, URL(string: "mailto:kdold02@gmail.com")!)
    }
    
    func test_openSourceRow_titleText() {
        let sut = SettingsRowViewModel(settingItem: .openSource)
        XCTAssertEqual(sut.titleText, "Source code")
    }
    
    func test_openSourceRow_subtitleText() {
        let sut = SettingsRowViewModel(settingItem: .openSource)
        XCTAssertEqual(sut.subtitleText, "Feel free to browse or contribute")
    }
    
    func test_openSourceRow_systemImageName() {
        let sut = SettingsRowViewModel(settingItem: .openSource)
        XCTAssertEqual(sut.systemImageName, "swift")
    }
    
    func test_openSourceRow_url() {
        let sut = SettingsRowViewModel(settingItem: .openSource)
        XCTAssertEqual(sut.url, URL(string: "https://github.com/kyledold/TaskIt")!)
    }
}
