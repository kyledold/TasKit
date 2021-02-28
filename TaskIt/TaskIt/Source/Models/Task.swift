//
//  Task.swift
//  NetworkKit
//
//  Created by Kyle Dold on 15/02/2021.
//

import Foundation
import CoreData

public class Task: NSManagedObject {
    
    // MARK: - Properties
    
    var unwrappedId: UUID { id ?? UUID() }
    var unwrappedTitle: String { title ?? "Unknown title" }
    var unwrappeDueDate: Date { dueDate ?? Date() }
    var subTasksArray: [SubTask]? { return subTasks?.allObjects as? Array<SubTask> }
    
    var status: Status {
        get { return Status(rawValue: statusValue)! }
        set { statusValue = newValue.rawValue }
    }
    
    var priority: Priority {
        get { return Priority(rawValue: priorityValue)! }
        set { priorityValue = newValue.rawValue }
    }
    
    // MARK: - Task CoreData Operations
    
    public static func fetchAll(viewContext: NSManagedObjectContext) -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dueDate", ascending: true)]
        guard let tasks = try? viewContext.fetch(fetchRequest) else { return [] }
        return tasks
    }
    
    public static func fetchAll(with status: Status, viewContext: NSManagedObjectContext) -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "statusValue == \(status.rawValue)")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dueDate", ascending: true)]
        guard let tasks = try? viewContext.fetch(fetchRequest) else { return [] }
        return tasks
    }
    
    public static func deleteAll(viewContext: NSManagedObjectContext) {
        Task.fetchAll(viewContext: viewContext).forEach { viewContext.delete($0) }
        try? viewContext.save()
    }
    
    public static func deleteTask(task: Task, viewContext: NSManagedObjectContext) {
        viewContext.delete(task)
        
        try? viewContext.save()
    }
    
    public static func updateStatus(task: Task, newStatus: Status, viewContext: NSManagedObjectContext) {
        task.status = newStatus
        
        try? viewContext.save()
    }
    
    public static func createNewTask(taskName: String, priority: Priority, dueDate: Date, viewContext: NSManagedObjectContext) {
        let task = Task(context: viewContext)
        
        task.title = taskName
        task.priority = priority
        task.dueDate = dueDate
        
        try? viewContext.save()
    }
    
    // MARK: - awake
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        createdAt = Date()
        id = UUID()
        status = .todo
    }
}
