//
//  Task+CoreDataProperties.swift
//  TasKit
//
//  Created by Kyle Dold on 27/03/2021.
//

import Foundation
import CoreData

extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> { NSFetchRequest<Task>(entityName: "Task") }

    @NSManaged public var createdAt: Date
    @NSManaged public var dueDate: Date
    @NSManaged public var dueTime: Date?
    @NSManaged public var id: UUID
    @NSManaged public var index: Int16
    @NSManaged public var isComplete: Bool
    @NSManaged public var isReminderSet: Bool
    @NSManaged public var notes: String?
    @NSManaged public var title: String
    @NSManaged public var subTasks: NSSet?
}

// MARK: - Generated accessors for subTasks

extension Task {

    @objc(addSubTasksObject:)
    @NSManaged public func addToSubTasks(_ value: SubTask)

    @objc(removeSubTasksObject:)
    @NSManaged public func removeFromSubTasks(_ value: SubTask)

    @objc(addSubTasks:)
    @NSManaged public func addToSubTasks(_ values: NSSet)

    @objc(removeSubTasks:)
    @NSManaged public func removeFromSubTasks(_ values: NSSet)

}
