//
//  TaskRowView.swift
//  TasKit
//
//  Created by Kyle Dold on 16/02/2021.
//

import SwiftUI

struct TaskRowView<ViewModel: TaskRowViewModelProtocol>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            
            taskDetails
            
            if let subTasksCompletionValue = viewModel.subTasksCompletionPercentage {
                subTaskProgressView(subTasksCompletionValue)
            }
        }
        .opacity(viewModel.isComplete ? 0.5 : 1)
        .padding(Layout.Spacing.compact)
    }
    
    private var taskDetails: some View {
        HStack(spacing: Layout.Spacing.compact) {
            
            CheckBox(isChecked: $viewModel.isComplete)
            
            Text(viewModel.title)
                .strikethrough(viewModel.isComplete, color: .primary)
                .font(.regular_16)
                .foregroundColor(.primary)
            
            Spacer()
            
            if let time = viewModel.time {
                HStack(spacing: Layout.Spacing.tight) {
                    Image(systemName: Image.Icons.alarm)
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 12, height: 12)
                    Text(time)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    private func subTaskProgressView(_ subTasksCompletionValue: Double) -> some View {
        HStack {
            ProgressView(String.empty, value: subTasksCompletionValue)
                .progressViewStyle(LinearProgressViewStyle(tint: .t_action))
                .font(.footnote)
            Spacer()
        }
        .padding([.top, .trailing], -Layout.Spacing.compact)
        .padding(.leading, Layout.Spacing.spacious)
    }
}

// MARK: - PreviewProvider -

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskRowView(viewModel: FakeTaskRowViewModel())
                .previewLayout(.fixed(width: 300, height: 200))
        }
    }
}
