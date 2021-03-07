//
//  TasksListView.swift
//  TaskIt
//
//  Created by Kyle Dold on 02/02/2021.
//

import SwiftUI
import Introspect

struct TasksListView<ViewModel: TasksListViewModelProtocol, SettingsModifier: ViewModifier, CalendarModifier: ViewModifier>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    
    let settingsModifier: SettingsModifier
    let calendarModifier: CalendarModifier
    
    @State private var showNewTaskView = false
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            VStack {
                navigationHeaderView
                taskListBodyView
            }
            .allowsHitTesting(!showNewTaskView)
            
            if showNewTaskView {
                NewTaskView(viewModel: viewModel.newTaskViewModel, showNewTaskView: $showNewTaskView)
            } else {
                createTaskFooterButton
            }
        }
        .navigationTitle(String.empty)
        .navigationBarHidden(true)
        .onAppear {
            viewModel.fetchTasks()
        }
        /*VStack {
            // This was s workaround to get sheet and fullscreenCover working
            // https://www.hackingwithswift.com/forums/swiftui/using-sheet-and-fullscreencover-together/4258
        }
        .present(isPresented: $toastPresenter.showToast) {
            toastPresenter.toastView()
        }*/
    }
    
    // MARK: - Events
    
    private func settingsButtonTapped() {
        viewModel.settingsButtonTapped()
    }
    
    private func calendarButtonTapped() {
        viewModel.calendarButtonTapped()
    }
}

extension TasksListView {
    
    private var navigationHeaderView: some View {
        HStack(spacing: Layout.Padding.cozy) {
            Spacer()
            
            Button(action: calendarButtonTapped, label: {
                Image(systemName: Image.Icons.calendar).iconStyle()
            }).modifier(calendarModifier)
            
            Button(action: settingsButtonTapped, label: {
                Image(systemName: Image.Icons.settings).iconStyle()
            }).modifier(settingsModifier)
        }
        .padding()
    }
    
    private var taskListBodyView: some View {
        
        List {
            ForEach(viewModel.taskViewModels, id: \.id) { rowViewModel in
                TaskRowView(viewModel: rowViewModel)
                    .onNavigation { viewModel.open(rowViewModel) }
            }
        }
        .id(UUID())
        .listRowInsets(EdgeInsets())
        
        /*ScrollView {
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
        }*/
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
            //toastPresenter.toast = .taskCreated
        }
    }
}

// MARK: - PreviewProvider -
/*
struct TasksListView_Previews: PreviewProvider {
    static var previews: some View {
        TasksListView(
            viewModel: FakeTasksListViewModel(),
            settingsModifier: FakeSheetModifier()
        )
    }
}
*/
