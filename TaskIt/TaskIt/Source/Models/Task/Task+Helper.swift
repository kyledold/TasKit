//
//  Task.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import Foundation
import CoreData

extension Task {
    
    // MARK: - Properties
    
    var unwrappedDueTime: Date { dueTime ?? dueDate.setTime(hour: 12, minute: 0) }
    var unwrappedNotes: String { notes ?? .empty }
    
    var subTasksArray: [SubTask]? {
        let subTaskArray = subTasks?.allObjects as? Array<SubTask>
        return subTaskArray?.sorted { $0.index < $1.index }
    }
    
    var subTasksCompletionPercentage: Double? {
        guard let completedSubTasksCount = subTasksArray?.filter({ $0.isComplete }).count else { return nil }
        guard let subTasksCount = subTasksArray?.count else { return nil }
        guard subTasksCount > 0 else { return nil }
    
        return Double(completedSubTasksCount) / Double(subTasksCount)
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
    
    public static func fetchTask(with id: UUID, viewContext: NSManagedObjectContext) -> Task? {
        print("Task fetchTask(for id:) called")
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        guard let tasks = try? viewContext.fetch(fetchRequest) else { return nil}
        return tasks.first
    }
    
    // MARK: - Delete
    
    public static func deleteAll(viewContext: NSManagedObjectContext) {
        Task.fetchAll(viewContext: viewContext).forEach { viewContext.delete($0) }
        
        try? viewContext.save()
        print("Task deleteAll called")
    }
    
    public static func deleteTask(task: Task, viewContext: NSManagedObjectContext) {
        
        print("Task \"\(task.title)\" deleted")
        
        viewContext.delete(task)
        
        try? viewContext.save()
    }
    
    // MARK: - Update
    
    public static func updateOrderOfTasks(_ revisedTasks: [Task], viewContext: NSManagedObjectContext) {
        
        for index in stride(from: revisedTasks.count - 1, through: 0, by: -1) {
            let task = revisedTasks[index]
            task.index = Int16(index)
            
            print("Task \"\(task.title)\" update index to \(index)")
        }
        
        try? viewContext.save()
    }
    
    public static func updateNotes(task: Task, notes: String, viewContext: NSManagedObjectContext) {
        task.notes = notes
        
        try? viewContext.save()
        print("Task \"\(task.title)\" notes updated to \"\(notes)\" ")
    }
    
    public static func updateDueDate(task: Task, dueDate: Date, viewContext: NSManagedObjectContext) {
        task.dueDate = dueDate
        
        try? viewContext.save()
        print("Task \"\(task.title)\" dueDate updated to \"\(String(describing: dueDate))\" ")
    }
    
    public static func updateDueTime(task: Task, dueTime: Date?, viewContext: NSManagedObjectContext) {
        task.dueTime = dueTime
        
        try? viewContext.save()
        print("Task \"\(task.title)\" dueTime updated to \"\(String(describing: dueTime))\" ")
    }
    
    public static func updateTitle(task: Task, title: String, viewContext: NSManagedObjectContext) {
        task.title = title
        
        try? viewContext.save()
        print("Task title updated to \"\(task.title)\"")
    }
    
    public static func updateCompletionStatus(task: Task, isComplete: Bool, viewContext: NSManagedObjectContext) {
        task.isComplete = isComplete
        
        try? viewContext.save()
        print("Task \"\(task.title)\" status updated to \"\(isComplete)\"")
    }
    
    public static func updateIsReminderSet(task: Task, isReminderSet: Bool, viewContext: NSManagedObjectContext) {
        task.isReminderSet = isReminderSet
        
        try? viewContext.save()
        print("Task \"\(task.title)\" isReminderSet updated to \"\(isReminderSet)\" ")
    }
    
    // MARK: - Create
    
    public static func create(title: String, dueDate: Date, index: Int, viewContext: NSManagedObjectContext) {
        let newTask = Task(context: viewContext)
        newTask.title = title
        newTask.dueDate = dueDate
        newTask.index = Int16(index)
        
        try? viewContext.save()
        print("Task \"\(title)\" created")
    }
    
    
    // MARK: - Awake
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        createdAt = Date()
        id = UUID()
        isComplete = false
    }
}
