//
//  SettingsRowViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 13/02/2021.
//

import XCTest
@testable import TaskIt

class SettingsRowViewModelTests: XCTestCase {
    
    func test_givenFeedbackRow_whenTitleTextCalled_thenReturnsExpectedValue() {
        // given
        let sut = SettingsRowViewModel(settingItem: .feedback)
        
        // when
        let result = sut.titleText
        
        // then
        XCTAssertEqual(result, "Feedback")
    }
    
    func test_givenFeedbackRow_whenSubtitleTextCalled_thenReturnsExpectedValue() {
        // given
        let sut = SettingsRowViewModel(settingItem: .feedback)
        
        // when
        let result = sut.subtitleText
        
        // then
        XCTAssertEqual(result, "kdold02@gmail.com")
    }
    
    func test_givenFeedbackRow_whenSystemImageNameCalled_thenReturnsExpectedValue() {
        // given
        let sut = SettingsRowViewModel(settingItem: .feedback)
        
        // when
        let result = sut.systemImageName
        
        // then
        XCTAssertEqual(result, "at")
    }
    
    func test_givenFeedbackRow_whenUrlCalled_thenReturnsExpectedValue() {
        // given
        let sut = SettingsRowViewModel(settingItem: .feedback)
        
        // when
        let result = sut.url
        
        // then
        XCTAssertEqual(result, URL(string: "mailto:kdold02@gmail.com")!)
    }
    
    func test_givenOpenSourceRow_whenTitleTextCalled_thenReturnsExpectedValue() {
        // given
        let sut = SettingsRowViewModel(settingItem: .openSource)
        
        // when
        let result = sut.titleText
        
        // then
        XCTAssertEqual(result, "Source code")
    }
    
    func test_givenOpenSourceRow_whenSubTitleTextCalled_thenReturnsExpectedValue() {
        // given
        let sut = SettingsRowViewModel(settingItem: .openSource)
        
        // when
        let result = sut.subtitleText
        
        // then
        XCTAssertEqual(result, "Feel free to browse or contribute")
    }
    
    func test_givenOpenSourceRow_whenSystemImageNameCalled_thenReturnsExpectedValue() {
        // given
        let sut = SettingsRowViewModel(settingItem: .openSource)
        
        // when
        let result = sut.systemImageName
        
        // then
        XCTAssertEqual(result, "swift")
    }
    
    func test_givenOpenSourceRow_whenUrlCalled_thenReturnsExpectedValue() {
        // given
        let sut = SettingsRowViewModel(settingItem: .openSource)
        
        // when
        let result = sut.url
        
        // then
        XCTAssertEqual(result, URL(string: "https://github.com/kyledold/TaskIt")!)
    }
}
