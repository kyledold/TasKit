//
//  TasksView.swift
//  TaskIt
//
//  Created by Kyle Dold on 02/02/2021.
//

import SwiftUI

struct TasksView<ViewModel: TasksViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var showAddTaskView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.taskViewModels, id: \.id) { task in
                    if let taskRowViewModel = task as? TaskRowViewModel {
                        TaskRowView(viewModel: taskRowViewModel)
                    }
                    #if DEBUG
                    if let fakeTaskRowViewModel = task as? FakeTaskRowViewModel {
                        TaskRowView(viewModel: fakeTaskRowViewModel)
                    }
                    #endif
                }
            }
            .listStyle(InsetListStyle())
                
            .navigationBarTitle(viewModel.titleText, displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    showAddTaskView.toggle()
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
            )
            .onAppear {
                viewModel.fetchTasks()
            }
            .sheet(isPresented: $showAddTaskView) {
                AddTaskView(
                    viewModel: AddTaskViewModel(
                        managedObjectContext: managedObjectContext,
                        onTaskAdded: {
                            viewModel.fetchTasks()
                        }
                    )
                )
            }
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(viewModel: FakeTaskViewModel())
    }
}
