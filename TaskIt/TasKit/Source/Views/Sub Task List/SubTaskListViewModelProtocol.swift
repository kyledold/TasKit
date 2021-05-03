//
//  SubTaskListViewModelProtocol.swift
//  TasKit
//
//  Created by Kyle Dold on 28/02/2021.
//

import Foundation

protocol SubTaskListViewModelProtocol: ObservableObject {
    
    associatedtype RowViewModel: SubTaskRowViewModelProtocol
    
    var headerText: String { get }
    var subTaskNamePlaceholderText: String { get }
    var newSubTaskName: String { get set }
    var subTaskModels: [RowViewModel] { get set }
    var isListInEditMode: Bool { get }
    var addSubTaskButtonText: String { get }
    var doneButtonText: String { get }
    var addButtonText: String { get }
    var cancelButtonText: String { get }
    var editButtonText: String { get }
    
    func deleteSubTask(at indexSet: IndexSet)
    func moveSubTask(from source: IndexSet, to destination: Int)
    func addSubTaskButtonTapped(_ completion: @escaping EmptyClosure)
    func editButtonTapped()
    func cancelButtonTapped()
}
