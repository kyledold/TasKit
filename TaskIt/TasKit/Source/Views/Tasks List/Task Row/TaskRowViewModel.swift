//
//  TaskRowViewModel.swift
//  TasKit
//
//  Created by Kyle Dold on 16/02/2021.
//

import Combine
import CoreData
import Foundation

class TaskRowViewModel: TaskRowViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var isComplete: Bool = false
    @Published var subTasksCompletionPercentage: Double?
    
    var id: UUID
    var taskId: UUID { task.id }
    var title: String { task.title }
    var time: String? {
        guard AppSettings.boolValue(.reminder) else { return nil }
        return task.dueTime?.shortTime ?? nil
    }
    var onChangeCompletion: ValueClosure<Bool>
    
    private var subscribers: Set<AnyCancellable> = []
    private(set) var task: Task
    private let notificationCenter = NotificationCenter.default
    private let managedObjectContext: NSManagedObjectContext
    
    // MARK: - Initialisation
    
    init(task: Task, managedObjectContext: NSManagedObjectContext, onChangeCompletion: @escaping ValueClosure<Bool>) {
        self.task = task
        self.managedObjectContext = managedObjectContext
        self.onChangeCompletion = onChangeCompletion
        self.id = UUID()
        
        self.isComplete = task.isComplete
        self.subTasksCompletionPercentage = task.subTasksCompletionPercentage
        addObservers()
    }
    
    // MARK: - Functions
    
    private func addObservers() {
        
        $isComplete.dropFirst().sink { [weak self] newValue in
            if newValue != self?.task.isComplete {
                self?.onChangeCompletion(newValue)
            }
        }.store(in: &subscribers)
        
        notificationCenter.publisher(for: Notification.Name.NSManagedObjectContextObjectsDidChange, object: managedObjectContext)
            .sink { [weak self] notification in
                guard let userInfo = notification.userInfo else { return }
                guard let updates = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject> else { return }
                
                for update in updates {
                    if let task = update as? Task, task.id == self?.taskId {
                        self?.isComplete = task.isComplete
                    }
                    
                    if let subTask = update as? SubTask {
                        guard subTask.task != nil else { return }
                        
                        if subTask.task.id == self?.taskId {
                            self?.subTasksCompletionPercentage = subTask.task.subTasksCompletionPercentage
                        }
                    }
                }
        }.store(in: &subscribers)
    }
}
