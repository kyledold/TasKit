//
//  TaskDetailsView.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import SwiftUI

struct TaskDetailsView<ViewModel: TaskDetailsViewModelProtocol>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var status = true
    @State private var showtextFieldToolbar = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            ScrollView {
                navigationBarView
                taskBasicDetailsView
                subTasksListView
            }
            .padding(.horizontal)
            footerView
        }
        .onAppear {
            viewModel.onAppear()
            showtextFieldToolbar = true
            
            // TODO: find a better way to handle this
            UITextView.appearance().backgroundColor = .clear
        }
    }
}

extension TaskDetailsView {
    
    private var navigationBarView: some View {
        HStack {
            Spacer()
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: Image.Icons.close)
            })
            .foregroundColor(Color.primary)
            .padding()
        }
    }
    
    private var taskBasicDetailsView: some View {
        VStack(spacing: Layout.Padding.cozy) {
            VStack(spacing: Layout.Padding.cozy) {
                
                HStack {
                    Toggle(isOn: $viewModel.isComplete) {}
                        .toggleStyle(CheckboxToggleStyle())
                    
                    TextField(viewModel.taskNamePlaceholderText, text: $viewModel.taskName)
                        .textFieldStyle(SimpleTextFieldStyle())
                }
                
                VStack(spacing: Layout.Padding.cozy) {
                    PrioritySegmentView(selectedPriority: $viewModel.priority)
                    
                    DatePicker(viewModel.taskDateText, selection: $viewModel.dueDate, displayedComponents: .date)
                        .accentColor(Color.t_black)
                }
                .padding(Layout.Padding.cozy)
                .background(Color.t_input_background)
                .cornerRadius(10)
                
                TextBox(viewModel.taskNotesPlaceholderText, text: $viewModel.taskNotes)
            }
        }
    }
    
    private var subTasksListView: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(viewModel.subTaskModels, id: \.id) { subTaskViewModel in
                    SubTaskRowView(viewModel: subTaskViewModel)
                }
            }
            .listSeparatorStyle(.none)
            .frame(height: viewModel.subTaskModels.reduce(0) { i, _ in i + 44 })
            
            Button(action: {
                
            }, label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Add a subtask")
                }
            })
            Spacer()
        }
    }
    
    private var footerView: some View {
        VStack {
            Spacer()
            if showtextFieldToolbar {
                HStack {
                    Button(action: {
                            viewModel.addNewTaskTapped() {
                                let generator = UINotificationFeedbackGenerator()
                                generator.notificationOccurred(.success)
                                presentationMode.wrappedValue.dismiss()
                            }
                        }, label: {
                            Text(viewModel.submitButtonText)
                        })
                        .buttonStyle(FullWidthButton(buttonColor: Color.t_green))
                }
                .frame(alignment: .center)
            }
        }
    }
}

// MARK: - PreviewProvider -

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsView(viewModel: FakeTaskDetailsViewModel())
    }
}
