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
    @Published var isListInEditMode: Bool = false
    
    var headerText = NSLocalizedString("subtask_list.subtasks", comment: "Subtask header")
    var subTaskNamePlaceholderText = NSLocalizedString("subtask_list.subtask_name_placeholder", comment: "Subtask textfield placeholder")
    var addSubTaskButtonText = NSLocalizedString("subtask_list.add_subtask", comment: "Add subtask button text")
    var addButtonText = NSLocalizedString("general.add", comment: "Add button text")
    var cancelButtonText = NSLocalizedString("general.cancel", comment: "Cancel button text")
    var doneButtonText = NSLocalizedString("general.done", comment: "Done button text")
    var editButtonText = NSLocalizedString("general.edit", comment: "Edit button text")
    
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
    
    func deleteSubTask(at indexSet: IndexSet) {
        
        let subTasksToDelete = indexSet.map { subTaskModels[$0].subTask }
        SubTask.deleteSubTasks(subTasksToDelete, viewContext: managedObjectContext)
        
        fetchSubTasks()
        resetListViewEditModeIfEmpty()
    }
    
    func moveSubTask(from source: IndexSet, to destination: Int) {
        
        var revisedSubTasks = subTaskModels.map { $0.subTask }
        revisedSubTasks.move(fromOffsets: source, toOffset: destination)
        
        SubTask.updateOrderOfSubTasks(revisedSubTasks, viewContext: managedObjectContext)
        
        fetchSubTasks()
    }
    
    func addSubTaskButtonTapped(_ completion: @escaping EmptyClosure) {
        SubTask.createNewSubTask(
            task: task,
            subTaskName: newSubTaskName,
            index: subTaskModels.count,
            viewContext: managedObjectContext
        )
        
        newSubTaskName = .empty
        fetchSubTasks()
        completion()
    }
    
    func editButtonTapped() {
        isListInEditMode.toggle()
    }
    
    func cancelButtonTapped() {
        newSubTaskName = .empty
    }
    
    private func fetchSubTasks() {
        subTaskModels = task.subTasksArray?.compactMap { subTask in
            SubTaskRowViewModel(subTask: subTask, onChangeCompletion: { [weak self] isComplete in
                self?.updateSubTaskCompletionStatus(subTask, isComplete: isComplete)
            })
        } ?? []
    }
    
    private func resetListViewEditModeIfEmpty() {
        if isListInEditMode {
            isListInEditMode = !subTaskModels.isEmpty
        }
    }
    
    private func updateSubTaskCompletionStatus(_ subTask: SubTask, isComplete: Bool) {
        SubTask.updateCompletionStatus(
            subTask,
            isComplete: isComplete,
            viewContext: managedObjectContext
        )
    }
}
