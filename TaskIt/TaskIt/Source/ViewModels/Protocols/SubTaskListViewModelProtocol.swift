//
//  SubTaskListViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 28/02/2021.
//

import Foundation

protocol SubTaskListViewModelProtocol: ObservableObject {
    
    associatedtype RowViewModel: SubTaskRowViewModelProtocol
    
    var subTaskNamePlaceholderText: String { get }
    var newSubTaskName: String { get set }
    var subTaskModels: [RowViewModel] { get set }
    var addSubTaskButtonText: String { get }
    
    func addNewSubTaskButtonTapped(_ completion: @escaping EmptyClosure)
}
