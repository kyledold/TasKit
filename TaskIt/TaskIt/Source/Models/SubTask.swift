//
//  SubTask.swift
//  TaskIt
//
//  Created by Kyle Dold on 28/02/2021.
//

import Foundation
import CoreData

public class SubTask: NSManagedObject {
    
    // MARK: - Properties
    
    var unwrappedId: UUID { id ?? UUID() }
    var unwrappedTitle: String { title ?? "Unknown title"}
    
    // MARK: - SubTask CoreData Operations
    
    public static func createNewSubTask(task: Task, subTaskName: String, viewContext: NSManagedObjectContext) {
        let subTask = SubTask(context: viewContext)
        
        subTask.task = task
        subTask.title = subTaskName
        
        try? viewContext.save()
    }
    
    public static func deleteSubTasks(subTasks: [SubTask], viewContext: NSManagedObjectContext) {
        subTasks.forEach {
            viewContext.delete($0)
            try? viewContext.save()
        }
    }
    
    // MARK: - awake
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        id = UUID()
        isComplete = false
    }
}
