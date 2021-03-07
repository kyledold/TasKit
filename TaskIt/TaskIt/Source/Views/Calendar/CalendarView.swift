//
//  CalendarView.swift
//  TaskIt
//
//  Created by Kyle Dold on 02/02/2021.
//

import SwiftUI

struct CalendarView<ViewModel: CalendarViewModelProtocol>: View {
    
    var viewModel: ViewModel
    
    var body: some View {
        VStack {
            
        }
        .navigationBarTitle(viewModel.titleText, displayMode: .inline)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(viewModel: FakeCalendarViewModel())
    }
}
