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
    @State private var feedback = UINotificationFeedbackGenerator()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // MARK: - View
    
    var body: some View {
        ScrollView {
            VStack {
                navigationBarView
                taskBasicDetailsView
                SubTaskListView(viewModel: viewModel.subTaskListViewModel)
                Spacer()
            }
            .padding(.horizontal)
            //footerView
        }
        .navigationBarHidden(true)
        .onAppear {
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
        VStack(spacing: Layout.Spacing.cozy) {
            VStack(spacing: Layout.Spacing.cozy) {
                
                HStack {
                    Toggle(isOn: $viewModel.isComplete) {}
                        .toggleStyle(CheckboxToggleStyle())
                        .onChange(of: viewModel.isComplete) { _ in
                            feedback.notificationOccurred(.success)
                        }
                    
                    TextField(viewModel.taskNamePlaceholderText, text: $viewModel.taskName)
                        .textFieldStyle(SimpleTextFieldStyle())
                }
                
                VStack(spacing: Layout.Spacing.cozy) {
                    DatePicker(viewModel.taskDateText, selection: $viewModel.dueDate, displayedComponents: .date)
                        .accentColor(Color.primary)
                }
                .padding(Layout.Spacing.cozy)
                .background(Color.t_input_background)
                .cornerRadius(10)
                
                TextBox(viewModel.taskNotesPlaceholderText, text: $viewModel.taskNotes)
            }
        }
    }
    
    /*
    private var footerView: some View {
        VStack {
            Spacer()
            if showInputAccessoryView {
                HStack {
                    Button(action: {
                            viewModel.submitButtonTapped() {
                                let generator = UINotificationFeedbackGenerator()
                                generator.notificationOccurred(.success)
                                
                                
                                presentationMode.wrappedValue.dismiss()
                            }
                        }, label: {
                            Text(viewModel.submitButtonText)
                        })
                        .disabled(viewModel.isSubmitButtonDisabled)
                        .buttonStyle(FullWidthButtonStyle(isDisabled: viewModel.isSubmitButtonDisabled, buttonColor: Color.t_green))
                }
                .frame(alignment: .center)
            }
        }
    }*/
}

// MARK: - PreviewProvider -

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsView(viewModel: FakeTaskDetailsViewModel())
    }
}
