//
//  TasksListView.swift
//  TaskIt
//
//  Created by Kyle Dold on 02/02/2021.
//

import SwiftUI

struct TasksListView<ViewModel: TasksListViewModelProtocol>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var navigator: TasksNavigator
    
    // MARK: - Content Builders
    
    var body: some View {
        ZStack {
            VStack {
                navigationHeaderView
                taskListBodyView
            }
            .backgroundOverlay()
            ButtonFooterView(
                buttonText: viewModel.createTaskButtonText,
                buttonColor: .t_orange,
                onButtonTap: {
                    navigator.sheetDestination = .addTask
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
    
    private var statusFilterView: some View {
        StatusSegmentView(selectedStatus: $viewModel.selectedStatusFilter)
            .onChange(of: viewModel.selectedStatusFilter) { viewModel.didChangeStatusFilter(status: $0) }
            .padding(.vertical, Layout.Padding.tight)
            .background(Color.t_background)
            .cornerRadius(25.0)
    }
    
    private var navigationHeaderView: some View {
        HStack(spacing: Layout.Padding.cozy) {
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
    
    private var taskListBodyView: some View {
        ScrollView {
            statusFilterView.padding(.horizontal, Layout.Padding.compact)
            ForEach(viewModel.taskViewModels, id: \.id) { task in
                if let taskRowViewModel = task as? TaskRowViewModel {
                    TaskRowView(viewModel: taskRowViewModel)
                        .onTapGesture {
                            UIImpactFeedbackGenerator().impactOccurred()
                            navigator.fullScreenDestination = .viewTask(task: taskRowViewModel.task)
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
}

// MARK: - PreviewProvider -

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksListView(viewModel: FakeTasksListViewModel(), navigator: TasksNavigator())
    }
}
