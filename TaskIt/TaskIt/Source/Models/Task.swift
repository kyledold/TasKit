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
    var unwrappedDueDate: Date { dueDate ?? Date() }
    var unwrappedDueTime: Date { dueTime ?? Date().setTime(hour: 12) }
    var unwrappedNotes: String { notes ?? .empty }
    var reminderTimeInterval: TimeInterval? {
        guard reminder > 0 else { return nil }
        return TimeInterval(reminder)
    }
    
    var subTasksArray: [SubTask]? {
        let subTaskArray = subTasks?.allObjects as? Array<SubTask>
        return subTaskArray?.sorted { $0.index < $1.index }
    }
    
    var status: Status {
        get { return Status(rawValue: statusValue)! }
        set { statusValue = newValue.rawValue }
    }
    
    // MARK: - Fetch
    
    public static func fetchAll(viewContext: NSManagedObjectContext) -> [Task] {
        print("Task fetchAll called")
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dueDate", ascending: true)]
        guard let tasks = try? viewContext.fetch(fetchRequest) else { return [] }
        return tasks
    }
    
    public static func fetchAll(for date: Date, viewContext: NSManagedObjectContext) -> [Task] {
        print("Task fetchAll(for date:) called")
        
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date)
        let endDate = calendar.date(byAdding: .hour, value: 24, to: startDate)!
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "dueDate = nil OR dueDate >= %@ AND dueDate <= %@", startDate as NSDate, endDate as NSDate)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "index", ascending: true)]
        guard let tasks = try? viewContext.fetch(fetchRequest) else { return [] }
        return tasks
    }
    
    // MARK: - Delete
    
    public static func deleteAll(viewContext: NSManagedObjectContext) {
        Task.fetchAll(viewContext: viewContext).forEach { viewContext.delete($0) }
        try? viewContext.save()
        
        print("Task deleteAll called")
    }
    
    public static func deleteTask(task: Task, viewContext: NSManagedObjectContext) {
        viewContext.delete(task)
        try? viewContext.save()
        
        print("Task \"\(task.unwrappedTitle)\" deleted")
    }
    
    // MARK: - Update
    
    public static func updateOrderOfTasks(_ revisedTasks: [Task], viewContext: NSManagedObjectContext) {
        
        for index in stride(from: revisedTasks.count - 1, through: 0, by: -1) {
            let task = revisedTasks[index]
            task.index = Int16(index)
            
            print("Task \"\(task.unwrappedTitle)\" update index to \(index)")
        }
        
        try? viewContext.save()
    }
    
    public static func updateNotes(task: Task, notes: String, viewContext: NSManagedObjectContext) {
        task.notes = notes
        
        try? viewContext.save()
        
        print("Task \"\(task.unwrappedTitle)\" notes updated to \"\(notes)\" ")
    }
    
    public static func updateDueDate(task: Task, dueDate: Date?, viewContext: NSManagedObjectContext) {
        task.dueDate = dueDate
        
        try? viewContext.save()
        
        print("Task \"\(task.unwrappedTitle)\" dueDate updated to \"\(String(describing: dueDate))\" ")
    }
    
    public static func updateDueTime(task: Task, dueTime: Date?, viewContext: NSManagedObjectContext) {
        task.dueTime = dueTime
        
        try? viewContext.save()
        
        print("Task \"\(task.unwrappedTitle)\" dueTime updated to \"\(String(describing: dueTime))\" ")
    }
    
    public static func updateTitle(task: Task, title: String, viewContext: NSManagedObjectContext) {
        task.title = title
        
        try? viewContext.save()
        
        print("Task \"\(task.unwrappedTitle)\" title updated to \"\(title)\" ")
    }
    
    public static func updateStatus(task: Task, newStatus: Status, viewContext: NSManagedObjectContext) {
        task.status = newStatus
        try? viewContext.save()
        
        print("Task \"\(task.unwrappedTitle)\" status updated to \"\(newStatus.rawValue)\"")
    }
    
    // MARK: - Create
    
    public static func create(title: String, viewContext: NSManagedObjectContext) {
        let newTask = Task(context: viewContext)
        newTask.title = title
        try? viewContext.save()
        
        print("Task \"\(title)\" created")
    }
    
    // MARK: - Save
    
    public static func saveChanges(viewContext: NSManagedObjectContext) {
        try? viewContext.save()
    }
    
    // MARK: - Awake
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        createdAt = Date()
        id = UUID()
        status = .todo
        index = Int16.max
    }
}
