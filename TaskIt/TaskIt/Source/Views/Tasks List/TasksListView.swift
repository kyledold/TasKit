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
    
    @State private var isListEditing = false
    @State private var showNewTaskView = false
    @State private var showCalendarView = false
    
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
        .navigationBarHidden(true)
        .bottomSheet(isPresented: $showCalendarView, height: 450) {
            CalendarView(viewModel: CalendarViewModel())
        }
        .onAppear {
            viewModel.fetchTasks()
        }
    }
    
    // MARK: - Events
    
    private func pencilButtonTapped() {
        isListEditing.toggle()
    }
    
    private func settingsButtonTapped() {
        viewModel.settingsButtonTapped()
    }
    
    private func calendarButtonTapped() {
        viewModel.calendarButtonTapped()
    }
}

extension TasksListView {
    
    private var navigationHeaderView: some View {
        HStack(spacing: Layout.Padding.spacious) {
            Text(viewModel.selectedDateText)
                .font(.largeTitle)
            
            Spacer()
            
            Button(action: pencilButtonTapped, label: {
                Image(systemName: isListEditing ? Image.Icons.tick : Image.Icons.sort).iconStyle()
            })
            
            Button(action: {
                showCalendarView = true
            }, label: {
                Image(systemName: Image.Icons.calendar).iconStyle()
            })
            
            /*Button(action: calendarButtonTapped, label: {
                Image(systemName: Image.Icons.calendar).iconStyle()
            }).modifier(calendarModifier)*/
            
            Button(action: settingsButtonTapped, label: {
                Image(systemName: Image.Icons.settings).iconStyle()
            }).modifier(settingsModifier)
        }
        .padding()
    }
    
    private var taskListBodyView: some View {
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
        .padding(.vertical, Layout.Padding.compact)
        .background(Color.t_input_background)
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

struct TasksListView_Previews: PreviewProvider {
    static var previews: some View {
        TasksListView(viewModel: FakeTasksListViewModel(), settingsModifier: FakeSheetModifier(), calendarModifier: FakeSheetModifier())
            
    }
}
