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
    @State private var showDeleteConfirmationAlert = false
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
        }
        .navigationBarHidden(true)
        .alert(isPresented: $showDeleteConfirmationAlert, content: { deleteConfirmationAlert })
        .bottomSheet(isPresented: $viewModel.showCalendarView, height: 450) {
            CalendarView(viewModel: viewModel.calendarViewModel)
        }
        .onAppear {
            // TODO: find a better way to handle this
            UITextView.appearance().backgroundColor = .clear
        }
    }
    
    // MARK: - Events
    
    private func backButtonTapped() {
        presentationMode.wrappedValue.dismiss()
    }
    
    private func calendarButtonTapped() {
        viewModel.calendarButtonTapped()
    }
    
    private func deleteButtonTapped() {
        showDeleteConfirmationAlert = true
        /*
        viewModel.deleteButtonTapped {
            
        }
         */
    }
}

extension TaskDetailsView {
    
    private var navigationBarView: some View {
        HStack {
            
            Button(action: backButtonTapped, label: {
                Image(systemName: Image.Icons.back)
            }).buttonStyle(ImageButtonStyle(buttonColor: .primary))
            
            Spacer()
            
            Button(action: deleteButtonTapped, label: {
                Text(viewModel.deleteButtonText)
            })
            .buttonStyle(TextNavigationButtonStyle(buttonColor: .t_red, textColor: .white))
            
        }.padding(.bottom, Layout.Spacing.compact)
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
                
                HStack {
                    Text(viewModel.taskDateText)
                    Spacer()
                    Button(action: calendarButtonTapped, label: {
                        HStack {
                            Text(viewModel.formattedDueDate)
                                .foregroundColor(.primary)
                        }
                        .padding(Layout.Spacing.compact)
                        .background(Color.t_input_background_2)
                        .cornerRadius(10)
                    })
                }
                .padding(Layout.Spacing.cozy)
                .background(Color.t_input_background)
                .cornerRadius(10)
                
                TextBox(viewModel.taskNotesPlaceholderText, text: $viewModel.taskNotes)
            }
        }
    }
    
    var deleteConfirmationAlert: Alert {
        Alert(
            title: Text(viewModel.deleteAlertTitleText),
            message: Text(viewModel.deleteAlertMessageText),
            primaryButton: .destructive(Text(viewModel.deleteButtonText), action: {
                viewModel.deleteButtonTapped {
                    presentationMode.wrappedValue.dismiss()
                }
            }),
            secondaryButton: .cancel()
        )
    }
}

// MARK: - PreviewProvider -

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsView(viewModel: FakeTaskDetailsViewModel())
    }
}
