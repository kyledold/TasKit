//
//  CalendarViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 07/03/2021.
//

import Combine
import Foundation

class CalendarViewModel: CalendarViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var selectedDate: Date
    
    var doneButtonText = NSLocalizedString("general.done", comment: "Done button text")
    var onDateSelected: ValueClosure<Date>?
    
    private var subscribers: Set<AnyCancellable> = []
    
    init(selectedDate: Date) {
        self.selectedDate = selectedDate
    }
    
    func doneButtonTapped() {
        onDateSelected?(selectedDate)
    }
}
