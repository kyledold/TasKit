//
//  TasksListView.swift
//  TaskIt
//
//  Created by Kyle Dold on 02/02/2021.
//

import SwiftUI
import Introspect

struct TasksListView<ViewModel: TasksListViewModelProtocol, SettingsModifier: ViewModifier>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    
    let settingsModifier: SettingsModifier
    private let notificationCenter = NotificationCenter.default
    
    @State private var isListEditing = false
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            VStack {
                navigationHeaderView
                taskListBodyView
            }
            .allowsHitTesting(!viewModel.showNewTaskView)
            
            if viewModel.showNewTaskView {
                NewTaskView(viewModel: viewModel.newTaskViewModel, showNewTaskView: $viewModel.showNewTaskView)
            } else {
                createTaskFooterButton
            }
        }
        .navigationBarHidden(true)
        .bottomSheet(isPresented: $viewModel.showCalendarView, height: 450) {
            CalendarView(viewModel: viewModel.calendarViewModel)
        }
        .onReceive(notificationCenter.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            viewModel.viewWillEnterForeground()
        }
    }
    
    // MARK: - Events
    
    private func sortButtonTapped() {
        isListEditing.toggle()
    }
    
    private func settingsButtonTapped() {
        viewModel.settingsButtonTapped()
    }
    
    private func calendarButtonTapped() {
        viewModel.calendarButtonTapped()
    }
    
    private func createTaskButtonTapped() {
        isListEditing = false
        withAnimation {
            viewModel.createTaskButtonTapped()
        }
    }
}

extension TasksListView {
    
    private var navigationHeaderView: some View {
        HStack(alignment: .firstTextBaseline, spacing: Layout.Spacing.spacious) {
            
            Text(viewModel.selectedDateText)
                .font(.medium_22)
            
            Spacer()
            
            if viewModel.showSortButton {
                Button(action: sortButtonTapped, label: {
                    Image(systemName: isListEditing ? Image.Icons.circleTick : Image.Icons.sort).iconStyle()
                })
            }
            
            Button(action: calendarButtonTapped, label: {
                Image(systemName: Image.Icons.calendar).iconStyle()
            })
            
            Button(action: settingsButtonTapped, label: {
                Image(systemName: Image.Icons.settings).iconStyle()
            }).modifier(settingsModifier)
        }
        .padding()
    }
    
    @ViewBuilder
    private var taskListBodyView: some View {
        if !viewModel.taskViewModels.isEmpty {
            taskList
        } else {
            emptyTaskList
        }
    }
    
    private var emptyTaskList: some View {
        VStack(spacing: 10) {
            Spacer()
            Image(systemName: Image.Icons.minusCalendar).placeholderStyle()
            Text(viewModel.emptyListText)
            Spacer()
            Spacer()
        }.foregroundColor(Color.t_gray)
    }
    
    private var taskList: some View {
        List {
            taskRows
        }
        .id(UUID())
        .listStyle(PlainListStyle())
        .introspectTableView { tableView in
            tableView.backgroundColor = .clear
            tableView.separatorStyle = .none
        }
        .environment(\.editMode, isListEditing ? .constant(.active) : .constant(.inactive))
    }
    
    private var taskRows: some View {
        ForEach(viewModel.taskViewModels, id: \.id) { rowViewModel in
            TaskRowView(viewModel: rowViewModel)
                .onNavigation { viewModel.taskRowTapped(rowViewModel) }
        }
        .onMove(perform: moveTask)
        .onDelete(perform: deleteTask)
        .deleteDisabled(isListEditing)
        .padding(.vertical, Layout.Spacing.compact)
        .cornerRadius(10.0)
        .listRowBackground(Color.t_background)
        .listRowInsets(EdgeInsets(top: 8, leading: isListEditing ? -24 : 16, bottom: 8, trailing: 16))
    }
    
    // MARK: - Events
    
    private func moveTask(from source: IndexSet, to destination: Int) {
        viewModel.moveTask(from: source, to: destination)
    }
    
    private func deleteTask(at indexSet: IndexSet) {
        viewModel.deleteTask(at: indexSet)
    }
}

extension TasksListView {
    
    private var createTaskFooterButton: some View {
        ButtonFooterView(
            buttonText: viewModel.createTaskButtonText,
            buttonColor: .t_action,
            onButtonTap: createTaskButtonTapped
        )
        .onNotification(.taskCreated) {
            //toastPresenter.toast = .taskCreated
        }
    }
}

// MARK: - PreviewProvider -

struct TasksListView_Previews: PreviewProvider {
    static var previews: some View {
        TasksListView(viewModel: FakeTasksListViewModel(), settingsModifier: FakeSheetModifier())
            
    }
}
