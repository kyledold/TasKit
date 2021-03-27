//
//  SubTask+CoreDataProperties.swift
//  TaskIt
//
//  Created by Kyle Dold on 27/03/2021.
//

import Foundation
import CoreData

extension SubTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubTask> { NSFetchRequest<SubTask>(entityName: "SubTask") }

    @NSManaged public var id: UUID
    @NSManaged public var index: Int16
    @NSManaged public var isComplete: Bool
    @NSManaged public var title: String
    @NSManaged public var task: Task

}
