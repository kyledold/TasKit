//
//  TasksView.swift
//  TaskIt
//
//  Created by Kyle Dold on 02/02/2021.
//

import SwiftUI

struct TasksView<ViewModel: TasksViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var navigator: TasksNavigator
    
    var body: some View {
        ZStack {
            VStack {
                navigationHeaderView
                ScrollView {
                    StatusFilterView.padding(.horizontal, Layout.Padding.compact)
                    ForEach(viewModel.taskViewModels, id: \.id) { task in
                        if let taskRowViewModel = task as? TaskRowViewModel {
                            TaskRowView(viewModel: taskRowViewModel)
                                .onTapGesture {
                                    UIImpactFeedbackGenerator().impactOccurred()
                                    navigator.fullScreenDestination = .viewTask(taskRowViewModel: taskRowViewModel)
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
            ButtonFooterView(
                buttonText: "Create task",
                buttonColor: .cyanBlue,
                onButtonTap: {
                    navigator.fullScreenDestination = .addTask
                }
            )
        }
        .fullScreenCover(isPresented: $navigator.showFullScreen) {
            navigator.fullScreenView()
        }
        VStack {
            // This was s workaround to get sheet and fullscreenCover working
            // https://www.hackingwithswift.com/forums/swiftui/using-sheet-and-fullscreencover-together/4258
        }
        .sheet(isPresented: $navigator.showSheet) {
            navigator.sheetView()
        }
        .onAppear {
            viewModel.fetchTasks()
        }
    }
    
    private var StatusFilterView: some View {
        StatusSegmentView(selectedStatus: $viewModel.selectedStatusFilter)
            .onChange(of: viewModel.selectedStatusFilter) { viewModel.didChangeStatusFilter(status: $0) }
            .padding(.vertical, Layout.Padding.tight)
            .background(Color.t_background)
            .cornerRadius(25.0)
    }
    
    private var navigationHeaderView: some View {
        HStack(spacing: 18) {
            Spacer()
            
            Button(action: {
                navigator.sheetDestination = .calendar
            }, label: {
                Image(systemName: Image.Icons.calendar).iconStyle()
            })
            
            Button(action: {
                navigator.sheetDestination = .settings
            }, label: {
                Image(systemName: Image.Icons.settings).iconStyle()
            })
        }
        .padding()
    }
    
    private func deleteTask(at indexSet: IndexSet) {
        viewModel.deleteTask(at: indexSet)
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(viewModel: FakeTaskViewModel(), navigator: TasksNavigator())
    }
}
