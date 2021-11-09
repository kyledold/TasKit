//
//  SyncSettingsViewModelTests.swift
//  TasKitTests
//
//  Created by Kyle Dold on 28/04/2021.
//

import XCTest
@testable import TaskIt

class SyncSettingsViewModelTests: XCTestCase {
    
    private lazy var sut = SyncSettingsViewModel()
    
    // MARK: - Properties
    
    func test_whenTitleTextCalled_thenReturnsExpectedString() {
        // given
        // when
        let result = sut.titleText
        
        // then
        XCTAssertEqual(result, "TasKit Sync")
    }
    
    func test_whenICloudSyncTextCalled_thenReturnsExpectedString() {
        // given
        // when
        let result = sut.iCloudSyncText
        
        // then
        XCTAssertEqual(result, "iCloud sync")
    }
    
    func test_whenICloudSyncDescriptionCalled_thenReturnsExpectedString() {
        // given
        // when
        let result = sut.iCloudSyncDescription
        
        // then
        XCTAssertEqual(result, "Use iCloud to sync tasks between your devices")
    }
}
