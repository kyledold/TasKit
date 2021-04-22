//
//  TaskDetailsViewModelTests.swift
//  TaskItTests
//
//  Created by Kyle Dold on 18/03/2021.
//

import XCTest
@testable import TaskIt

class TaskDetailsViewModelTests: XCTestCase {
    
    private static let mockPersistenceController = PersistenceController(inMemory: true)
    private lazy var mockTask = Task.StubFactory.make(
        title: "Mock task",
        dueTime: Date(),
        isReminderSet: true,
        persistenceController: Self.mockPersistenceController
    )
    
    private lazy var sut = TaskDetailsViewModel(
        task: mockTask,
        onDateChanged: {},
        managedObjectContext: Self.mockPersistenceController.container.viewContext
    )
    
    override class func tearDown() {
        mockPersistenceController.container.viewContext.rollback()
        super.tearDown()
    }
    
    // MARK: - Properties
    
    func test_whenTaskNameCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.taskName
        
        // then
        XCTAssertEqual(result, mockTask.title)
    }
    
    func test_whenDueDateCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.dueDate
        
        // then
        XCTAssertEqual(result, mockTask.dueDate)
    }
    
    func test_whenDueTimeCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.dueTime
        
        // then
        XCTAssertEqual(result, mockTask.dueTime)
    }
    
    func test_whenIsCompleteCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.isComplete
        
        // then
        XCTAssertEqual(result, mockTask.isComplete)
    }
    
    func test_whenTaskNotesCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.taskNotes
        
        // then
        XCTAssertEqual(result, mockTask.notes)
    }
    
    func test_whenFormattedDueDateCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.formattedDueDate
        
        // then
        XCTAssertEqual(result, mockTask.dueDate.shortDate)
    }
    
    func test_whenShowCalendarViewCalled_thenReturnsFalse() {
        // given
        // when
        let result = sut.showCalendarView
        
        // then
        XCTAssertEqual(result, false)
    }
    
    func test_givenTaskWithDueTime_whenIsTimeToggledOnCalled_thenReturnsTrue() {
        // given
        // when
        let result = sut.isTimeToggledOn
        
        // then
        XCTAssertEqual(result, true)
    }
    
    func test_givenTaskWithoutDueTime_whenIsTimeToggledOnCalled_thenReturnsFalse() {
        // given
        let mockTask = Task.StubFactory.make(
            title: "Mock task",
            persistenceController: Self.mockPersistenceController
        )
        
        let sut = TaskDetailsViewModel(
            task: mockTask,
            onDateChanged: {},
            managedObjectContext: Self.mockPersistenceController.container.viewContext
        )
        
        // when
        let result = sut.isTimeToggledOn
        
        // then
        XCTAssertEqual(result, false)
    }
    
    func test_givenTaskWithReminderSet_whenIsReminderToggledOnCalled_thenReturnsTrue() {
        // given
        // when
        let result = sut.isTimeToggledOn
        
        // then
        XCTAssertEqual(result, true)
    }
    
    func test_givenTaskWithoutReminderSet_whenIsReminderToggledOnCalled_thenReturnsFalse() {
        // given
        let mockTask = Task.StubFactory.make(
            title: "Mock task",
            isReminderSet: true,
            persistenceController: Self.mockPersistenceController
        )
        
        let sut = TaskDetailsViewModel(
            task: mockTask,
            onDateChanged: {},
            managedObjectContext: Self.mockPersistenceController.container.viewContext
        )
        
        // when
        let result = sut.isReminderToggledOn
        
        // then
        XCTAssertEqual(result, true)
    }
    
    func test_whenDeleteAlertTitleTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.deleteAlertTitleText
        
        // then
        XCTAssertEqual(result, "Delete task")
    }
    
    func test_whenDeleteAlertMessageTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.deleteAlertMessageText
        
        // then
        XCTAssertEqual(result, "Are you sure you want to delete this task?")
    }
    
    func test_whenDeleteButtonTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.deleteButtonText
        
        // then
        XCTAssertEqual(result, "Delete")
    }
    
    func test_whenReminderTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.reminderText
        
        // then
        XCTAssertEqual(result, "Reminder")
    }
    
    func test_whenTaskNamePlaceholderTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.taskNamePlaceholderText
        
        // then
        XCTAssertEqual(result, "Task name")
    }
    
    func test_whenTaskNotesPlaceholderTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.taskNotesPlaceholderText
        
        // then
        XCTAssertEqual(result, "Write any notes here...")
    }
    
    func test_whenTaskDateTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.taskDateText
        
        // then
        XCTAssertEqual(result, "Date")
    }
    
    func test_whenTimeTextCalled_thenReturnsExpectedValue() {
        // given
        // when
        let result = sut.timeText
        
        // then
        XCTAssertEqual(result, "Time")
    }
    
    func test_whenTaskDateChanged_thenOnDateChangedClosureCalled() {
        // given
        var onDateChangedNumberOfCalls = 0
        sut.onDateChanged = {
            onDateChangedNumberOfCalls += 1
        }
        
        // when
        sut.dueDate = Date().addDays(numberOfDays: 1)
        
        // then
        XCTAssertEqual(onDateChangedNumberOfCalls, 1)
    }
    
    func test_whenDeleteButtonTapped_thenTaskIsDeleted() {
        // given
        let mockTaskToBeDeleted = Task.StubFactory.make(
            title: "Mock task",
            dueTime: Date(),
            isReminderSet: true,
            persistenceController: Self.mockPersistenceController
        )
        let mockTaskToBeDeletedId = mockTaskToBeDeleted.id
        
        let sut = TaskDetailsViewModel(
            task: mockTaskToBeDeleted,
            onDateChanged: {},
            managedObjectContext: Self.mockPersistenceController.container.viewContext
        )
        
        // when
        sut.deleteButtonTapped { }
        
        // then
        let task = Task.fetchTask(with: mockTaskToBeDeletedId, viewContext: Self.mockPersistenceController.container.viewContext)
        XCTAssertNil(task)
    }
    
    func test_whenCalendarButtonTapped_thenShowCalendarViewIsTrue() {
        // given
        // when
        sut.calendarButtonTapped()
        
        // then
        XCTAssertEqual(sut.showCalendarView, true)
    }
}
