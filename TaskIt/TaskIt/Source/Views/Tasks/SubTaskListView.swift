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
        VStack(alignment: .leading) {
            List {
                ForEach(viewModel.subTaskModels, id: \.id) { subTaskViewModel in
                    SubTaskRowView(viewModel: subTaskViewModel)
                }
            }
            .listSeparatorStyle(.none)
            .frame(height: viewModel.subTaskModels.reduce(0) { i, _ in i + 44 })
            
            if showAddNewSubTaskRow {
                HStack {
                    TextField(viewModel.subTaskNamePlaceholderText, text: $viewModel.newSubTaskName)
                        .textFieldStyle(SimpleTextFieldStyle())
                    
                    Button(action: {
                        viewModel.addNewSubTaskButtonTapped() {
                            showAddNewSubTaskRow.toggle()
                        }
                    }, label: {
                        HStack {
                            Text("Add")
                        }
                    })
                }
            } else {
                Button(action: {
                    showAddNewSubTaskRow.toggle()
                }, label: {
                    HStack {
                        Image(systemName: Image.Icons.add)
                        Text(viewModel.addSubTaskButtonText)
                    }
                }).padding(.leading, Layout.Padding.squished)
            }
            Spacer()
        }
        .padding(.bottom, Layout.Padding.luxurious)
    }
}

// MARK: - PreviewProvider -

struct SubTaskListView_Previews: PreviewProvider {
    static var previews: some View {
        SubTaskListView(viewModel: FakeSubTaskListViewModel())
    }
}
