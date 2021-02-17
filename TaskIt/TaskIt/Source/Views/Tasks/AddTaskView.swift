//
//  AddTaskView.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import SwiftUI

struct AddTaskView<ViewModel: AddTaskViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: Layout.Padding.cozy) {
            Spacer()
            
            TextField(viewModel.taskNamePlaceholder, text: $viewModel.taskName)
                .frame(height: 40)
            
            PrioritySegmentView(selectedPriority: $viewModel.priority)
            
            Spacer()
            Button(action: {
                viewModel.addNewTaskTapped() {
                    presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text("Add Task")
            })
        }
        .onAppear {
            viewModel.onAppear()
        }
        .padding(.horizontal, Layout.Padding.spacious)
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(viewModel: FakeAddTaskViewModel())
    }
}
