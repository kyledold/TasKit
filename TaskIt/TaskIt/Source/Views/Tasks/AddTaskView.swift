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
        VStack {
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Add Task")
            })
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(viewModel: FakeAddTaskViewModel())
    }
}
