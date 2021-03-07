//
//  NewTaskViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 06/03/2021.
//

import Combine
import CoreData
import Foundation

class NewTaskViewModel: NewTaskViewModelProtocol {
    
    @Published var taskName: String = .empty
    @Published var isCreateButtonDisabled: Bool = false
    
    let taskNamePlaceholder = NSLocalizedString("new_task.task_name.placeholder", comment: "Task name placeholder")
    
    var onTaskAdded: EmptyClosure?
    
    private var subscribers: Set<AnyCancellable> = []
    private let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        
        addObservers()
    }
    
    func createTaskButtonTapped(_ completion: @escaping EmptyClosure) {
        Task.create(title: taskName, viewContext: managedObjectContext)
        
        onTaskAdded?()
        completion()
        
        taskName = .empty
    }
    
    private func addObservers() {
        $taskName.sink(receiveValue: { [weak self] taskName in
            self?.isCreateButtonDisabled = taskName.isBlank
        }).store(in: &subscribers)
    }
}