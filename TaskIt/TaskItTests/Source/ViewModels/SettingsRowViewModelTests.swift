//
//  SettingsRowViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 13/02/2021.
//

import XCTest
@testable import TaskIt

class SettingsRowViewModelTests: XCTestCase {
    
    func test_feedbackRow_titleTextKey() {
        let sut = SettingsRowViewModel(settingItem: .feedback)
        XCTAssertEqual(sut.titleTextKey, "settings.feedback.title")
    }
    
    func test_feedbackRow_subtitleTextKey() {
        let sut = SettingsRowViewModel(settingItem: .feedback)
        XCTAssertEqual(sut.subtitleTextKey, "settings.feedback.subtitle")
    }
    
    func test_feedbackRow_systemImageName() {
        let sut = SettingsRowViewModel(settingItem: .feedback)
        XCTAssertEqual(sut.systemImageName, "at")
    }
    
    func test_feedbackRow_url() {
        let sut = SettingsRowViewModel(settingItem: .feedback)
        XCTAssertEqual(sut.url, URL(string: "mailto:kdold02@gmail.com")!)
    }
    
    func test_openSourceRow_titleTextKey() {
        let sut = SettingsRowViewModel(settingItem: .openSource)
        XCTAssertEqual(sut.titleTextKey, "settings.open_source.title")
    }
    
    func test_openSourceRow_subtitleTextKey() {
        let sut = SettingsRowViewModel(settingItem: .openSource)
        XCTAssertEqual(sut.subtitleTextKey, "settings.open_source.subtitle")
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
