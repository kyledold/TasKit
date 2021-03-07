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
    var unwrappedNotes: String { notes ?? .empty }
    
    var subTasksArray: [SubTask]? {
        let subTaskArray = subTasks?.allObjects as? Array<SubTask>
        return subTaskArray?.sorted { $0.index < $1.index }
    }
    
    var status: Status {
        get { return Status(rawValue: statusValue)! }
        set { statusValue = newValue.rawValue }
    }
    
    // MARK: - Task CoreData Operations
    
    public static func fetchAll(viewContext: NSManagedObjectContext) -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
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
    
    public static func create(title: String, viewContext: NSManagedObjectContext) {
        let newTask = Task(context: viewContext)
        newTask.title = title
        try? viewContext.save()
    }
    
    public static func updateTask(
        task: Task,
        taskName: String,
        dueDate: Date,
        taskNotes: String,
        viewContext: NSManagedObjectContext
    ) {
        task.title = taskName
        task.dueDate = dueDate
        task.notes = taskNotes
        try? viewContext.save()
    }
    
    public static func saveChanges(viewContext: NSManagedObjectContext) {
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
