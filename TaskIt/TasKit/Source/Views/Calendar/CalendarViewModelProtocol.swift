//
//  CalendarViewModelProtocol.swift
//  TasKit
//
//  Created by Kyle Dold on 07/03/2021.
//

import Foundation

protocol CalendarViewModelProtocol: ObservableObject {
    
    var selectedDate: Date { get set }
    var doneButtonText: String { get }
    var onDateSelected: ValueClosure<Date>? { get set }
    
    func doneButtonTapped()
}
