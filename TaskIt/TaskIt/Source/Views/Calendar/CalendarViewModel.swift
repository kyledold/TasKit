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
    
    var onDateSelected: ValueClosure<Date>?
    
    private var subscribers: Set<AnyCancellable> = []
    
    init(selectedDate: Date) {
        self.selectedDate = selectedDate
        
        addObservers()
    }
    
    private func addObservers() {
        $selectedDate.dropFirst().sink(receiveValue: { [weak self] selectedDate in
            self?.onDateSelected?(selectedDate)
        }).store(in: &subscribers)
    }
}
