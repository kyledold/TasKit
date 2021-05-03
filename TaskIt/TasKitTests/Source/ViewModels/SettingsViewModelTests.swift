//
//  SettingsViewModelTests.swift
//  TasKitTests
//
//  Created by Kyle Dold on 28/04/2021.
//

import XCTest
@testable import TaskIt

class SettingsViewModelTests: XCTestCase {
    
    private lazy var sut = SettingsViewModel()
    
    // MARK: - Properties
    
    func test_whenTitleTextCalled_thenReturnsExpectedString() {
        // given
        // when
        let result = sut.titleText
        
        // then
        XCTAssertEqual(result, "Settings")
    }
    
    func test_whenVersionNumberCalled_thenReturnsExpectedString() {
        // given
        // when
        let result = sut.versionNumber
        
        // then
        XCTAssertEqual(result, "1.0.0")
    }
    
    func test_whenListBehaviourTextCalled_thenReturnsExpectedString() {
        // given
        // when
        let result = sut.listBehaviourText
        
        // then
        XCTAssertEqual(result, "List Behaviour")
    }
    
    func test_whenSyncTextCalled_thenReturnsExpectedString() {
        // given
        // when
        let result = sut.syncText
        
        // then
        XCTAssertEqual(result, "TasKit Sync")
    }
}
