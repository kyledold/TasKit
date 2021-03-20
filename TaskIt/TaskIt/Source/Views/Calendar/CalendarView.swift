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
        VStack {
            HStack {
                Spacer()
                Button(action: doneButtonTapped, label: {
                    Text(viewModel.doneButtonText)
                })
                .buttonStyle(TextNavigationButtonStyle(buttonColor: .blue, textColor: .white))
            }.padding(.horizontal, Layout.Spacing.cozy)
            
            DatePicker(String.empty, selection: $viewModel.selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
        }
    }
    
    private func doneButtonTapped() {
        viewModel.doneButtonTapped()
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(viewModel: FakeCalendarViewModel())
            .previewLayout(.fixed(width: 350, height: 400))
    }
}
