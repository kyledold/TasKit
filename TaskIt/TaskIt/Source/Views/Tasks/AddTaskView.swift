//
//  AddTaskView.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct AddTaskView<ViewModel: AddTaskViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: Layout.Padding.cozy) {
            Spacer()
            
            FloatingLabelTextField($viewModel.taskName, placeholder: viewModel.taskNamePlaceholder)
                .floatingStyle(InputTextFieldStyle())
                .frame(height: 40)
            
            Spacer()
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Add Task")
            })
        }
        .padding(.horizontal, Layout.Padding.spacious)
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(viewModel: FakeAddTaskViewModel())
    }
}
