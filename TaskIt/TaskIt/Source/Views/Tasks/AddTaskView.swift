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
            
            TextField(viewModel.taskNamePlaceholderText, text: $viewModel.taskName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(height: 40)
            
            PrioritySegmentView(selectedPriority: $viewModel.priority)
            
            DatePicker(viewModel.taskDateText, selection: $viewModel.dueDate, displayedComponents: .date)
            
            Button(action: {
                viewModel.addNewTaskTapped() {
                    presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text("Add Task")
            })
            
            Spacer()
        }
        .onAppear {
            viewModel.onAppear()
        }
        .frame(height: 250)
        .padding(.horizontal, Layout.Padding.spacious)
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(viewModel: FakeAddTaskViewModel())
    }
}
