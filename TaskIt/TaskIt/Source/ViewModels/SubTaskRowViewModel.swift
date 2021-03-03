//
//  SubTaskRowViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 28/02/2021.
//

import Combine
import Foundation

class SubTaskRowViewModel: SubTaskRowViewModelProtocol {
    
    var id: UUID { return subTask.unwrappedId }
    var subTaskTitle: String { return subTask.unwrappedTitle}
    
    @Published var isComplete: Bool
    
    var onChangeCompletion: ValueClosure<Bool>
    
    private var subscribers: Set<AnyCancellable> = []
    private(set) var subTask: SubTask
    
    init(subTask: SubTask, onChangeCompletion: @escaping ValueClosure<Bool>) {
        self.subTask = subTask
        self.isComplete = subTask.isComplete
        self.onChangeCompletion = onChangeCompletion
        
        $isComplete.dropFirst().sink { [weak self] isComplete in
            self?.onChangeCompletion(isComplete)
        }.store(in: &subscribers)
    }
}