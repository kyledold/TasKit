//
//  TasksView.swift
//  TaskIt
//
//  Created by Kyle Dold on 02/02/2021.
//

import SwiftUI

struct TasksView<ViewModel: TasksViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @State var selectedTask: TaskRowViewModel? = .none
    @State private var isAddTaskViewShown = false
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        ZStack {
            VStack {
                HomeNavigationSection()
                ScrollView {
                    StatusFilterSection.padding(.horizontal, 8)
                    ForEach(viewModel.taskViewModels, id: \.id) { task in
                        if let taskRowViewModel = task as? TaskRowViewModel {
                            TaskRowView(viewModel: taskRowViewModel)
                                .onTapGesture {
                                    UIImpactFeedbackGenerator().impactOccurred()
                                    selectedTask = taskRowViewModel
                                }
                        }
                        #if DEBUG
                        if let fakeTaskRowViewModel = task as? FakeTaskRowViewModel {
                            TaskRowView(viewModel: fakeTaskRowViewModel)
                        }
                        #endif
                    }
                }
            }
            .backgroundOverlay()
            FooterSection()
        }
        .fullScreenCover(item: $selectedTask) { room in
            TaskView()
        }
        .onAppear {
            viewModel.fetchTasks()
        }
    }
    
    var StatusFilterSection: some View {
        StatusSegmentView(selectedStatus: $viewModel.selectedStatusFilter)
            .onChange(of: viewModel.selectedStatusFilter) { viewModel.didChangeStatusFilter(status: $0) }
            .padding(.vertical, 4)
            .background(Color.t_background)
            .cornerRadius(25.0)
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

private struct HomeNavigationSection: View {
    var body: some View {
        HStack(spacing: 18) {
            Spacer()
            Button(action: {}){Image(systemName: Image.Icons.calendar).iconStyle() }
            Button(action: {}){Image(systemName: Image.Icons.settings).iconStyle() }
        }
        .padding()
    }
}

private struct FooterSection: View {
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Button(action: {
                    
                }, label: {
                    Text("+ Create task")
                })
                .font(.title20)
                .foregroundColor(.white)
                .padding(.vertical,8).padding(.horizontal)
                .background(Color.cyanBlue)
                .cornerRadius(30)
                .padding(.bottom, 48)
            }
        }.ignoresSafeArea(.all)
    }
}
