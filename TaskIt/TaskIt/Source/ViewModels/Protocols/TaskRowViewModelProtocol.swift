//
//  TaskRowViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import Foundation

protocol TaskRowViewModelProtocol {
    
    var id: Int { get }
    var titleText: String { get }
    var priority: Priority { get }
}

