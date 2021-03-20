//
//  SubTaskRowViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 18/03/2021.
//

import XCTest
@testable import TaskIt

class SubTaskRowViewModelTests: XCTestCase {
    
    private lazy var mockTask = Task.StubFactory.make(title: "Mock task")
    private lazy var mockSubTask = SubTask.StubFactory.make(task: mockTask, title: "Mock sub-task")
    private lazy var sut = SubTaskRowViewModel(
        subTask: mockSubTask,
        onChangeCompletion: { _ in }
    )
    
    // MARK: - Properties
    
    func test_givenDefaultInit_whenIsCompleteCalled_thenReturnsFalse() {
        // given
        // when
        let result = sut.isComplete
        
        // then
        XCTAssertEqual(result, false)
    }
    
    func test_givenDefaultInit_whenIdCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.id
        
        // then
        XCTAssertEqual(result, mockSubTask.id)
    }
    
    func test_givenDefaultInit_whenSubTaskTitleCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.subTaskTitle
        
        // then
        XCTAssertEqual(result, mockSubTask.title)
    }
}
