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
    
    public static func createNewSubTask(task: Task, subTaskName: String, index: Int, viewContext: NSManagedObjectContext) {
        let subTask = SubTask(context: viewContext)
        
        subTask.task = task
        subTask.title = subTaskName
        subTask.index = Int16(index)
        
        try? viewContext.save()
        
        print("SubTask \"\(subTask.unwrappedTitle)\" created")
    }
    
    public static func deleteSubTasks(_ subTasks: [SubTask], viewContext: NSManagedObjectContext) {
        subTasks.forEach {
            viewContext.delete($0)
            try? viewContext.save()
            
            print("SubTask \"\($0.unwrappedTitle)\" deleted")
        }
    }
    
    public static func updateOrderOfSubTasks(_ revisedSubTasks: [SubTask], viewContext: NSManagedObjectContext) {
        
        for index in stride(from: revisedSubTasks.count - 1, through: 0, by: -1) {
            let subTask = revisedSubTasks[index]
            subTask.index = Int16(index)
            
            print("SubTask \"\(subTask.unwrappedTitle)\" update index to \(index)")
        }
        
        try? viewContext.save()
    }
    
    public static func updateCompletionStatus(_ subTask: SubTask, isComplete: Bool, viewContext: NSManagedObjectContext) {
        subTask.isComplete = isComplete
        try? viewContext.save()
        
        print("SubTask \"\(subTask.unwrappedTitle)\" update completion status to \(isComplete)")
    }
    
    // MARK: - awake
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        id = UUID()
        isComplete = false
    }
}
