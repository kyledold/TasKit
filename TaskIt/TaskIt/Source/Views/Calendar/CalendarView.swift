//
//  CalendarView.swift
//  TaskIt
//
//  Created by Kyle Dold on 02/02/2021.
//

import SwiftUI

struct CalendarView<ViewModel: CalendarViewModelProtocol>: View {
    
    var viewModel: ViewModel
    @State private var date = Date()
    
    var body: some View {
        VStack {
            Spacer()
            DatePicker("Enter your birthday", selection: $date, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .frame(maxHeight: 400)
        }
        .padding()
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(viewModel: FakeCalendarViewModel())
    }
}
