//
//  SubTaskListView.swift
//  TaskIt
//
//  Created by Kyle Dold on 28/02/2021.
//

import SwiftUI

struct SubTaskListView<ViewModel: SubTaskListViewModelProtocol>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var showAddNewSubTaskRow = false
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: Layout.Spacing.squished) {
            
            headerView
            subTaskListView
            
            if !viewModel.isListInEditMode {
                addNewTaskView
            }
            Spacer()
        }
        .padding(.bottom, Layout.Spacing.luxurious)
    }
    
    // MARK: - Events
    
    private func deleteSubTask(at indexSet: IndexSet) {
        viewModel.deleteSubTask(at: indexSet)
    }
    
    func moveSubTask(from source: IndexSet, to destination: Int) {
        viewModel.moveSubTask(from: source, to: destination)
    }
    
    private func addSubTaskButtonTapped() {
        showAddNewSubTaskRow.toggle()
    }
    
    private func doneButtonTapped() {
        viewModel.addSubTaskButtonTapped() {
            showAddNewSubTaskRow.toggle()
        }
    }
    
    private func cancelButtonTapped() {
        viewModel.cancelButtonTapped()
        showAddNewSubTaskRow.toggle()
    }
    
    private func editButtonTapped() {
        viewModel.editButtonTapped() 
    }
}

extension SubTaskListView {
    
    private var headerView: some View {
        HStack {
            Text(viewModel.headerText)
                .font(.bold_20)
            
            Spacer()
            
            if viewModel.subTaskModels.count > 0 {
                Button(action: editButtonTapped, label: {
                    Text(viewModel.isListInEditMode ? viewModel.doneButtonText : viewModel.editButtonText)
                })
            }
        }
    }
    
    private var subTaskListView: some View {
        List {
            ForEach(viewModel.subTaskModels, id: \.id) { subTaskViewModel in
                SubTaskRowView(viewModel: subTaskViewModel)
            }
            .onDelete(perform: deleteSubTask)
            .onMove(perform: moveSubTask)
            .listRowInsets(EdgeInsets())
        }
        .id(UUID()) // this fixes a weird bug in List that doesn't show rows when adding for the first time
        .introspectTableView { tableView in
            tableView.backgroundColor = .clear
        }
        .frame(height: viewModel.subTaskModels.reduce(0) { i, _ in i + 44 }) // this is here to make list fit contents
        .environment(\.editMode, viewModel.isListInEditMode ? .constant(.active) : .constant(.inactive))
    }
    
    @ViewBuilder
    private var addNewTaskView: some View {
        if showAddNewSubTaskRow {
            newSubTaskInputView
        } else {
            addNewSubTaskButton
        }
    }
    
    private var newSubTaskInputView: some View {
        VStack(alignment: .leading, spacing: Layout.Spacing.compact) {
            TextField(viewModel.subTaskNamePlaceholderText, text: $viewModel.newSubTaskName)
                .textFieldStyle(SimpleTextFieldStyle())
            
            HStack(spacing: Layout.Spacing.cozy) {
                Button(action: doneButtonTapped, label: { Text(viewModel.addButtonText) })
                    .disabled(viewModel.newSubTaskName.isBlank)
                
                Button(action: cancelButtonTapped, label: { Text(viewModel.cancelButtonText) })
            }
        }
    }
    
    private var addNewSubTaskButton: some View {
        Button(action: addSubTaskButtonTapped, label: {
            HStack {
                Image(systemName: Image.Icons.add)
                Text(viewModel.addSubTaskButtonText)
            }
        })
        .padding(.leading, Layout.Spacing.squished)
        .padding(.vertical, Layout.Spacing.compact)
    }
}

// MARK: - PreviewProvider -

struct SubTaskListView_Previews: PreviewProvider {
    static var previews: some View {
        SubTaskListView(viewModel: FakeSubTaskListViewModel())
    }
}
