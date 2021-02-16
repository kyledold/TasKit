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
                Section() {
                    ForEach(viewModel.tasks, id: \.id) { task in
                        Text(task.title ?? String.empty)
                            .modifier(SubTitleStyle())
                            
                    }
                }
                
            }
            .listStyle(InsetGroupedListStyle())
                
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
