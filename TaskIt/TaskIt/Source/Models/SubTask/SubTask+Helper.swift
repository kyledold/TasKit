//
//  SubTask.swift
//  TaskIt
//
//  Created by Kyle Dold on 28/02/2021.
//

import Foundation
import CoreData

extension SubTask {
    
    // MARK: - Create
    
    public static func createNewSubTask(task: Task, subTaskName: String, index: Int, viewContext: NSManagedObjectContext) {
        let subTask = SubTask(context: viewContext)
        
        subTask.task = task
        subTask.title = subTaskName
        subTask.index = Int16(index)
        
        print("Sub-task \"\(subTask.title)\" created")
        
        try? viewContext.save()
    }
    
    // MARK: - Delete
    
    public static func deleteSubTasks(_ subTasks: [SubTask], viewContext: NSManagedObjectContext) {
        subTasks.forEach {
            viewContext.delete($0)
            
            print("Sub-task \"\($0.title)\" deleted")
        }
        
        try? viewContext.save()
    }
    
    // MARK: - Update
    
    public static func updateOrderOfSubTasks(_ revisedSubTasks: [SubTask], viewContext: NSManagedObjectContext) {
        
        for index in stride(from: revisedSubTasks.count - 1, through: 0, by: -1) {
            let subTask = revisedSubTasks[index]
            subTask.index = Int16(index)
            
            print("Sub-task \"\(subTask.title)\" update index to \(index)")
        }
        
        try? viewContext.save()
    }
    
    public static func updateCompletionStatus(_ subTask: SubTask, isComplete: Bool, viewContext: NSManagedObjectContext) {
        subTask.isComplete = isComplete
        
        try? viewContext.save()
        
        print("Sub-task \"\(subTask.title)\" update completion status to \(isComplete)")
    }
    
    // MARK: - awake
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        id = UUID()
        isComplete = false
        index = Int16.max
    }
}
