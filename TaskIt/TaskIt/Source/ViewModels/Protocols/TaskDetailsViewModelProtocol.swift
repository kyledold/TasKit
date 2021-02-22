//
//  TaskDetailsViewModelProtocol.swift
//  TaskIt
//
//  Created by Kyle Dold on 21/02/2021.
//

import Foundation

protocol TaskDetailsViewModelProtocol {
    
    var titleText: String { get }
    var priority: Priority { get }
}
