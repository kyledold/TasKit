//
//  CalendarView.swift
//  TaskIt
//
//  Created by Kyle Dold on 02/02/2021.
//

import SwiftUI

struct CalendarView<ViewModel: CalendarViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        DatePicker("Enter your birthday", selection: $viewModel.selectedDate, displayedComponents: .date)
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(viewModel: FakeCalendarViewModel())
    }
}
