//
//  SubTaskListViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 18/03/2021.
//

import XCTest
@testable import TaskIt

class SubTaskListViewModelTests: XCTestCase {
    
    private static let mockPersistenceController = PersistenceController(inMemory: true)

    private lazy var mockTask = Task.StubFactory.make(
        title: "Mock task",
        persistenceController: Self.mockPersistenceController
    )
    
    private lazy var sut = SubTaskListViewModel(
        task: mockTask,
        managedObjectContext: Self.mockPersistenceController.container.viewContext
    )
    
    override class func tearDown() {
        mockPersistenceController.container.viewContext.rollback()
        super.tearDown()
    }
    
    func test_whenNewSubTaskNameCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.newSubTaskName
        
        // then
        XCTAssertEqual(result, "")
    }
    
    func test_givenSubTasks_whenSubTaskModelsCalled_thenReturnsExpectedValue() {
        // given
        let mockFirstSubTask = SubTask.StubFactory.make(
            task: mockTask,
            title: "First subtask",
            index: 0,
            persistenceController: Self.mockPersistenceController
        )
        let mockSecondSubTask = SubTask.StubFactory.make(
            task: mockTask,
            title: "Second subtask",
            index: 1,
            persistenceController: Self.mockPersistenceController
        )
        let sut = SubTaskListViewModel(
            task: mockTask,
            managedObjectContext: Self.mockPersistenceController.container.viewContext
        )
        
        // when
        let result = sut.subTaskModels
        
        // then
        XCTAssertEqual(result.count, 2)
        let firstSubTask = result[0]
        XCTAssertEqual(firstSubTask.title, mockFirstSubTask.title)
        let secondSubTask = result[1]
        XCTAssertEqual(secondSubTask.title, mockSecondSubTask.title)
    }
    
    func test_whenIsListInEditModeCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.isListInEditMode
        
        // then
        XCTAssertEqual(result, false)
    }
    
    func test_whenHeaderTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.headerText
        
        // then
        XCTAssertEqual(result, "Sub-tasks")
    }
    
    func test_whenSubTaskNamePlaceholderTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.subTaskNamePlaceholderText
        
        // then
        XCTAssertEqual(result, "Enter sub-task name here...")
    }
    
    func test_whenAddSubTaskButtonTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.addSubTaskButtonText
        
        // then
        XCTAssertEqual(result, "Add a sub-task")
    }
    
    func test_whenAddButtonTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.addButtonText
        
        // then
        XCTAssertEqual(result, "Add")
    }
    
    func test_whenCancelButtonTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.cancelButtonText
        
        // then
        XCTAssertEqual(result, "Cancel")
    }
    
    func test_whenDoneButtonTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.doneButtonText
        
        // then
        XCTAssertEqual(result, "Done")
    }
    
    func test_whenEditButtonTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.editButtonText
        
        // then
        XCTAssertEqual(result, "Edit")
    }
    
    func test_givenSubTasks_whenDeleteSubTaskAtIndexCalled_thenDeletesSubTaskAtCorrectIndex() {
        // given
        let mockFirstSubTask = SubTask.StubFactory.make(
            task: mockTask,
            title: "First subtask",
            index: 0,
            persistenceController: Self.mockPersistenceController
        )
        _ = SubTask.StubFactory.make(
            task: mockTask,
            title: "Second subtask",
            index: 1,
            persistenceController: Self.mockPersistenceController
        )
        let mockThirdSubTask = SubTask.StubFactory.make(
            task: mockTask,
            title: "Third subtask",
            index: 2,
            persistenceController: Self.mockPersistenceController
        )
        let sut = SubTaskListViewModel(
            task: mockTask,
            managedObjectContext: Self.mockPersistenceController.container.viewContext
        )
        let indexToBeDeleted: IndexSet = [1]
        
        // when
        sut.deleteSubTask(at: indexToBeDeleted)
        
        // then
        XCTAssertEqual(sut.subTaskModels.count, 2)
        let firstSubTask = sut.subTaskModels[0]
        XCTAssertEqual(firstSubTask.title, mockFirstSubTask.title)
        let secondSubTask = sut.subTaskModels[1]
        XCTAssertEqual(secondSubTask.title, mockThirdSubTask.title)
    }
    
    func test_givenSubTasks_whenMoveSubTaskCalled_thenUpdatesSubTasksIndexsAccordingly() {
        // given
        let mockFirstSubTask = SubTask.StubFactory.make(
            task: mockTask,
            title: "First subtask",
            index: 0,
            persistenceController: Self.mockPersistenceController
        )
        let mockSecondSubTask = SubTask.StubFactory.make(
            task: mockTask,
            title: "Second subtask",
            index: 1,
            persistenceController: Self.mockPersistenceController
        )
        let mockThirdSubTask = SubTask.StubFactory.make(
            task: mockTask,
            title: "Third subtask",
            index: 2,
            persistenceController: Self.mockPersistenceController
        )
        let sut = SubTaskListViewModel(
            task: mockTask,
            managedObjectContext: Self.mockPersistenceController.container.viewContext
        )
        let indexToBeMoved: IndexSet = [0]
        
        // when
        sut.moveSubTask(from: indexToBeMoved, to: 3)
        
        // then
        XCTAssertEqual(sut.subTaskModels.count, 3)
        
        let firstSubTask = sut.subTaskModels[0]
        XCTAssertEqual(firstSubTask.title, mockSecondSubTask.title)
        XCTAssertEqual(firstSubTask.subTask.index, mockSecondSubTask.index)
        
        let secondSubTask = sut.subTaskModels[1]
        XCTAssertEqual(secondSubTask.title, mockThirdSubTask.title)
        XCTAssertEqual(secondSubTask.subTask.index, mockThirdSubTask.index)
        
        let thirdSubTask = sut.subTaskModels[2]
        XCTAssertEqual(thirdSubTask.title, mockFirstSubTask.title)
        XCTAssertEqual(thirdSubTask.subTask.index, mockFirstSubTask.index)
    }
    
    func test_givenSubTaskNameEntered_whenAddButtonTapped_thenSubTaskIsCreated() {
        // given
        let subTaskName = "sub task test name entry"
        sut.newSubTaskName = subTaskName
        
        // when
        sut.addSubTaskButtonTapped { }
        
        // then
        let result = sut.subTaskModels[0]
        XCTAssertEqual(result.title, subTaskName)
        XCTAssertEqual(result.subTask.index, 0)
        XCTAssertEqual(result.subTask.task.id, mockTask.id)
    }
    
    func test_givenSubTaskNameIsBlank_whenAddButtonTapped_thenSubTaskIsNotCreated() {
        // given
        let subTaskName = " "
        sut.newSubTaskName = subTaskName
        
        // when
        sut.addSubTaskButtonTapped { }
        
        // then
        XCTAssertEqual(sut.subTaskModels.count, 0)
    }
    
    func test_givenListIsInEditMode_whenEditButtonTapped_thenListIsNotInEditMode() {
        // given
        sut.isListInEditMode = true
        
        // when
        sut.editButtonTapped()
        
        // then
        XCTAssertEqual(sut.isListInEditMode, false)
    }
    
    func test_givenListIsNotInEditMode_whenEditButtonTapped_thenListIsInEditMode() {
        // given
        sut.isListInEditMode = false
        
        // when
        sut.editButtonTapped()
        
        // then
        XCTAssertEqual(sut.isListInEditMode, true)
    }
    
    func test_givenSubTaskNameEntered_whenCancelButtonTapped_thenSubTaskNameIsEmpty() {
        // given
        sut.newSubTaskName = "This is a test subtask"
        
        // when
        sut.cancelButtonTapped()
        
        // then
        XCTAssertEqual(sut.newSubTaskName, .empty)
    }
}
