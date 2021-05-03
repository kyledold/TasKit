//
//  SubTaskRowViewModelProtocol.swift
//  TasKit
//
//  Created by Kyle Dold on 28/02/2021.
//

import Foundation

protocol SubTaskRowViewModelProtocol: ObservableObject, Identifiable {
    
    var id: UUID { get }
    var title: String { get }
    var isComplete: Bool { get set }
    var subTask: SubTask { get }
}
