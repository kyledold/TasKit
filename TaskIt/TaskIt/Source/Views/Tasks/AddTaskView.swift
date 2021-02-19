//
//  AddTaskView.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import SwiftUI

struct AddTaskView<ViewModel: AddTaskViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @Binding var isAddTaskViewShown: Bool
    
    var body: some View {
        VStack(spacing: Layout.Padding.cozy) {
            
            Spacer()
            
            TextField(viewModel.taskNamePlaceholderText, text: $viewModel.taskName)
            .textFieldStyle(SimpleTextFieldStyle())
            .ignoresSafeArea(.keyboard, edges: .bottom)
            
            PrioritySegmentView(selectedPriority: $viewModel.priority)
            
            DatePicker(viewModel.taskDateText, selection: $viewModel.dueDate, displayedComponents: .date)
                .accentColor(Color.primary)
            
            Button(action: {
                viewModel.addNewTaskTapped() {
                    isAddTaskViewShown = false
                }
            }, label: {
                Text("Add Task")
            })
            .buttonStyle(FilledButtonStyle())
            
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
        AddTaskView(viewModel: FakeAddTaskViewModel(), isAddTaskViewShown: .constant(true))
            .previewLayout(.fixed(width: 400, height: 250))
    }
}
