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
    
    @Published var isComplete: Bool = false
    @Published var subTasksCompletionPercentage: Double?
    
    var id: UUID { task.id }
    var title: String { task.title }
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
        
        addObservers()
    }
    
    // MARK: - Functions
    
    func viewAppeared() {
        self.isComplete = task.isComplete
        self.subTasksCompletionPercentage = task.subTasksCompletionPercentage
    }
    
    private func addObservers() {
        $isComplete.dropFirst().sink { [weak self] newValue in
            if newValue != self?.task.isComplete {
                self?.onChangeCompletion(newValue)
            }
        }.store(in: &subscribers)
    }
}
