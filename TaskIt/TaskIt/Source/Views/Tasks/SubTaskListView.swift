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
    @State private var isListViewEditable = false
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: Layout.Padding.squished) {
            
            headerView
            subTaskListView
            
            if !isListViewEditable {
                addNewTaskView
            }
            Spacer()
        }
        .padding(.bottom, Layout.Padding.luxurious)
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
    
    private func editButtonTapped() {
        isListViewEditable.toggle()
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
                    Text(isListViewEditable ? viewModel.doneButtonText : viewModel.editButtonText)
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

        }
        .listSeparatorStyle(.none)
        .frame(height: viewModel.subTaskModels.reduce(0) { i, _ in i + 44 }) // this is here to make list fit contents
        .environment(\.editMode, isListViewEditable ? .constant(.active) : .constant(.inactive))
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
        HStack {
            TextField(viewModel.subTaskNamePlaceholderText, text: $viewModel.newSubTaskName)
                .textFieldStyle(SimpleTextFieldStyle())
            
            Button(action: doneButtonTapped, label: { Text(viewModel.doneButtonText) })
        }
    }
    
    private var addNewSubTaskButton: some View {
        Button(action: addSubTaskButtonTapped, label: {
            HStack {
                Image(systemName: Image.Icons.add)
                Text(viewModel.addSubTaskButtonText)
            }
        })
        .padding(.leading, Layout.Padding.squished)
        .padding(.vertical, Layout.Padding.compact)
    }
}

// MARK: - PreviewProvider -

struct SubTaskListView_Previews: PreviewProvider {
    static var previews: some View {
        SubTaskListView(viewModel: FakeSubTaskListViewModel())
    }
}
