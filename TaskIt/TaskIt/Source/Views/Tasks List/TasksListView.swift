//
//  TasksListView.swift
//  TaskIt
//
//  Created by Kyle Dold on 02/02/2021.
//

import SwiftUI
import Introspect

struct TasksListView<ViewModel: TasksListViewModelProtocol>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var navigator: TaskItCoordinator
    @ObservedObject var toastPresenter: ToastPresenter
    
    @State private var showNewTaskView = false
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            VStack {
                navigationHeaderView
                taskListBodyView
            }
            .allowsHitTesting(!showNewTaskView)
            .backgroundOverlay()
            
            if showNewTaskView {
                NewTaskView(viewModel: viewModel.newTaskViewModel, showNewTaskView: $showNewTaskView)
            } else {
                createTaskFooterButton
            }
        }
        VStack {
            // This was s workaround to get sheet and fullscreenCover working
            // https://www.hackingwithswift.com/forums/swiftui/using-sheet-and-fullscreencover-together/4258
        }
        .fullScreenCover(isPresented: $navigator.showSheet) {
            navigator.sheetView()
        }
        .present(isPresented: $toastPresenter.showToast) {
            toastPresenter.toastView()
        }
        .onAppear {
            viewModel.fetchTasks()
        }
    }
}

extension TasksListView {
    
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
            ForEach(viewModel.taskViewModels, id: \.id) { taskRowViewModel in
                TaskRowView(viewModel: taskRowViewModel)
                    .onTapGesture {
                        navigator.sheetDestination = .taskDetails(task: taskRowViewModel.task, onChange: {
                            viewModel.fetchTasks()
                        })
                    }
            }
        }
        .onNotification(.taskCompleted) {
            toastPresenter.toast = .taskCompleted
        }
        .onNotification(.taskDeleted) {
            toastPresenter.toast = .taskDeleted
        }
        .onNotification(.taskUpdated) {
            toastPresenter.toast = .taskUpdated
        }
    }
    
    private var createTaskFooterButton: some View {
        ButtonFooterView(
            buttonText: viewModel.createTaskButtonText,
            buttonColor: .t_orange,
            onButtonTap: {
                withAnimation {
                    showNewTaskView = true
                }
            }
        )
        .onNotification(.taskCreated) {
            toastPresenter.toast = .taskCreated
        }
    }
}

// MARK: - PreviewProvider -

struct TasksListView_Previews: PreviewProvider {
    static var previews: some View {
        TasksListView(viewModel: FakeTasksListViewModel(), navigator: TaskItCoordinator(), toastPresenter: ToastPresenter())
    }
}
