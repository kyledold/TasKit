//
//  CalendarViewModel.swift
//  TasKit
//
//  Created by Kyle Dold on 07/03/2021.
//

import Foundation

class CalendarViewModel: CalendarViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var selectedDate: Date
    
    var doneButtonText = NSLocalizedString("general.done", comment: "Done button text")
    var onDateSelected: ValueClosure<Date>?
    
    init(selectedDate: Date) {
        self.selectedDate = selectedDate
    }
    
    func doneButtonTapped() {
        onDateSelected?(selectedDate)
    }
}
