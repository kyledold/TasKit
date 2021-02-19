//
//  TasksView.swift
//  TaskIt
//
//  Created by Kyle Dold on 02/02/2021.
//

import SwiftUI
import PartialSheet

struct TasksView<ViewModel: TasksViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @State private var isAddTaskViewShown = false
    
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        NavigationView {
            VStack {
                StatusSegmentView(selectedStatus: $viewModel.selectedStatusFilter)
                    .onChange(of: viewModel.selectedStatusFilter) { viewModel.didChangeStatusFilter(status: $0) }
                
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
                    }.onDelete(perform: deleteTask)
                }
                .listStyle(InsetListStyle())
                
                Spacer()
            }
                
            .navigationBarTitle(viewModel.titleText, displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    isAddTaskViewShown.toggle()
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
            )
            .partialSheet(isPresented: $isAddTaskViewShown) {
                AddTaskView(
                    viewModel: AddTaskViewModel(
                        managedObjectContext: managedObjectContext,
                        onTaskAdded: {
                            viewModel.fetchTasks()
                        }
                    ),
                    isAddTaskViewShown: $isAddTaskViewShown
                )
            }
            .addPartialSheet(style: .defaultStyle())
            .onAppear {
                viewModel.fetchTasks()
            }
        }
    }
    
    private func deleteTask(at indexSet: IndexSet) {
        viewModel.deleteTask(at: indexSet)
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(viewModel: FakeTaskViewModel())
    }
}
