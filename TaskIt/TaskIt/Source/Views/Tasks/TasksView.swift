//
//  TasksView.swift
//  TaskIt
//
//  Created by Kyle Dold on 02/02/2021.
//

import SwiftUI

struct TasksView<ViewModel: TasksViewModelProtocol>: View {
    
    var viewModel: ViewModel
    
    @State private var showAddTaskView = false
    
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                
            .navigationBarTitle(LocalizedStringKey(viewModel.titleTextKey), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    showAddTaskView.toggle()
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
            )
            .sheet(isPresented: $showAddTaskView) {
                AddTaskView(viewModel: AddTaskViewModel())
            }
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(viewModel: FakeTaskViewModel())
    }
}
