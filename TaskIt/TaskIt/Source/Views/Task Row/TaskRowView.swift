//
//  TaskRowView.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import SwiftUI

struct TaskRowView<ViewModel: TaskRowViewModelProtocol>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - View
    
    var body: some View {
        HStack {
            
            Toggle(isOn: $viewModel.isComplete) {}
                .toggleStyle(CheckboxToggleStyle())
            
            /*VStack(alignment: .center) {
                Text(viewModel.dayOfTheWeekText).font(.regular_12).foregroundColor(Color.t_red)
                Text(viewModel.dateText).font(.bold_24)
                Text(viewModel.monthText).font(.regular_14)
            }.frame(minWidth: 40)
            
            Rectangle()
                .foregroundColor(.primary)
                .frame(width: 0.2)
             */
            
            Text(viewModel.taskTitle)
                .strikethrough(viewModel.isComplete, color: .primary)
                .font(.regular_16)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding(Layout.Padding.compact)
    }
}

// MARK: - PreviewProvider -

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskRowView(viewModel: FakeTaskRowViewModel())
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 300, height: 80))
        }
    }
}
