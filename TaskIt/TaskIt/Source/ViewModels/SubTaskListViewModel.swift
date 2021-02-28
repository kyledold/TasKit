//
//  SubTaskListViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 28/02/2021.
//

import CoreData
import Foundation

class SubTaskListViewModel: SubTaskListViewModelProtocol {
    
    typealias RowViewModel = SubTaskRowViewModel
    
    // MARK: - Properties
    
    @Published var newSubTaskName = String.empty
    @Published var subTaskModels: [SubTaskRowViewModel]
    
    var subTaskNamePlaceholderText = NSLocalizedString("subtask_list.subtask_name_placeholder", comment: "Subtask textfield placeholder")
    var addSubTaskButtonText = NSLocalizedString("subtask_list.add_subtask", comment: "Add subtask button text")
    
    private let managedObjectContext: NSManagedObjectContext
    private let task: Task
    
    // MARK: - Initialisation
    
    init(
        task: Task,
        managedObjectContext: NSManagedObjectContext
    ) {
        self.task = task
        self.managedObjectContext = managedObjectContext
        self.subTaskModels = []
        
        fetchSubTasks()
    }
    
    // MARK: - Functions
    
    func addNewSubTaskButtonTapped(_ completion: @escaping EmptyClosure) {
        SubTask.createNewSubTask(
            task: task,
            subTaskName: newSubTaskName,
            viewContext: managedObjectContext
        )
        
        newSubTaskName = .empty
        fetchSubTasks()
        completion()
    }
    
    private func fetchSubTasks() {
        subTaskModels = task.subTasksArray?.compactMap { SubTaskRowViewModel(subTask: $0) } ?? []
    }
}
