//
//  AddTaskView.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import SwiftUI

struct AddTaskView<ViewModel: AddTaskViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        
    var body: some View {
        VStack(spacing: Layout.Padding.cozy) {
            
            TextField(viewModel.taskNamePlaceholderText, text: $viewModel.taskName)
                .textFieldStyle(SimpleTextFieldStyle())
                .ignoresSafeArea(.keyboard, edges: .bottom)
            
            PrioritySegmentView(selectedPriority: $viewModel.priority)
            
            DatePicker(viewModel.taskDateText, selection: $viewModel.dueDate, displayedComponents: .date)
                .accentColor(Color.primary)
            
            Button(action: {
                viewModel.addNewTaskTapped() {
                    presentationMode.wrappedValue.dismiss()
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
        .padding(.horizontal, Layout.Padding.spacious)
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(viewModel: FakeAddTaskViewModel())
    }
}
