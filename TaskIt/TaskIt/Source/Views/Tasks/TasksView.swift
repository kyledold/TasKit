//
//  TasksView.swift
//  TaskIt
//
//  Created by Kyle Dold on 02/02/2021.
//

import SwiftUI

struct TasksView<ViewModel: TasksViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @State private var isAddTaskViewShown = false

    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        NavigationView {
            List {
                Section(header: header) {
                    ForEach(viewModel.taskViewModels, id: \.id) { task in
                        NavigationLink(
                            destination: AddTaskView(
                                viewModel: AddTaskViewModel(
                                    managedObjectContext: managedObjectContext,
                                    onTaskAdded: {
                                        viewModel.fetchTasks()
                                    }
                                )
                            ),
                            label: {
                                if let taskRowViewModel = task as? TaskRowViewModel {
                                    TaskRowView(viewModel: taskRowViewModel)
                                        .padding([.horizontal], Layout.Padding.tight)
                                        .padding([.vertical], Layout.Padding.squished)
                                }
                                #if DEBUG
                                if let fakeTaskRowViewModel = task as? FakeTaskRowViewModel {
                                    TaskRowView(viewModel: fakeTaskRowViewModel)
                                        .padding([.horizontal], Layout.Padding.tight)
                                        .padding([.vertical], Layout.Padding.squished)
                                }
                                #endif
                            })
                    }.onDelete(perform: deleteTask)
                }
            }
            .listStyle(InsetListStyle())
            .listSeparatorStyle(.none)
            .navigationBarTitle(viewModel.titleText)
            .navigationBarItems(trailing:
                Button(action: {
                    isAddTaskViewShown.toggle()
                }) {
                    Text("Add")
                    /*Image(systemName: "plus")
                        .padding(.trailing, 10)
                        .imageScale(.large)*/
                }
            )
            .onAppear {
                viewModel.fetchTasks()
            }
        }
    }
    
    var header: some View {
        StatusSegmentView(selectedStatus: $viewModel.selectedStatusFilter)
            .onChange(of: viewModel.selectedStatusFilter) { viewModel.didChangeStatusFilter(status: $0) }
            .padding(.vertical, Layout.Padding.compact)
            .background(Color.white)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
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
