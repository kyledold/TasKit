//
//  TaskRowViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import Combine
import CoreData
import Foundation

class TaskRowViewModel: TaskRowViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var isComplete: Bool
    @Published var subTasksCompletionPercentage: Double?
    
    var id: UUID { task.unwrappedId }
    var title: String { task.unwrappedTitle }
    var time: String? { task.dueTime?.shortTime ?? nil }
    var onChangeCompletion: ValueClosure<Bool>
    
    private var subscribers: Set<AnyCancellable> = []
    private(set) var task: Task
    private let managedObjectContext: NSManagedObjectContext
    
    // MARK: - Initialisation
    
    init(task: Task, managedObjectContext: NSManagedObjectContext, onChangeCompletion: @escaping ValueClosure<Bool>) {
        self.task = task
        self.managedObjectContext = managedObjectContext
        self.onChangeCompletion = onChangeCompletion
        self.isComplete = task.status == .completed
        
        addObservers()
    }
    
    // MARK: - Functions
    
    func viewAppeared() {
        self.subTasksCompletionPercentage = task.subTasksCompletionPercentage
    }
    
    private func addObservers() {
        $isComplete.dropFirst().sink { [weak self] isComplete in
            self?.onChangeCompletion(isComplete)
        }.store(in: &subscribers)
    }
}
