//
//  TaskRowView.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import SwiftUI

struct TaskRowView<ViewModel: TaskRowViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack(spacing: Layout.Padding.cozy) {
            
            Button(action: {
                viewModel.completeButtonTapped()
            }) {
                Image(systemName: viewModel.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.cyanBlue)
            }
            
            Text(viewModel.titleText)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
            
            if viewModel.priority != .none {
                Circle()
                    .fill(Color.color(for: viewModel.priority))
                    .frame(width: 10)
            }
        }
        .padding(16)
        .frame(height: 50)
        .listRowInsets(EdgeInsets())
    }
}


struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskRowView(viewModel: FakeTaskRowViewModel())
                .previewLayout(.fixed(width: 300, height: 50))
        }
    }
}
