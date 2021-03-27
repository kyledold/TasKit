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
        VStack {
            navigationBarView
            ScrollView {
                VStack {
                    taskBasicDetailsView
                    SubTaskListView(viewModel: viewModel.subTaskListViewModel)
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
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
        UIApplication.shared.endEditing()
        presentationMode.wrappedValue.dismiss()
    }
    
    private func calendarButtonTapped() {
        viewModel.calendarButtonTapped()
    }
    
    private func deleteButtonTapped() {
        showDeleteConfirmationAlert = true
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
                
                VStack(spacing: Layout.Spacing.compact) {
                    dueDateRow
                    timeRow
                }
                .padding(Layout.Spacing.cozy)
                .background(Color.t_input_background)
                .cornerRadius(Layout.Spacing.compact)
                
                TextBox(viewModel.taskNotesPlaceholderText, text: $viewModel.taskNotes)
            }
        }
    }

    private var dueDateRow: some View {
        VStack {
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
                    .cornerRadius(Layout.Spacing.compact)
                })
            }
        }
    }
    
    private var timeRow: some View {
        VStack {
            HStack {
                Text(viewModel.timeText)
                Spacer()
                Toggle(isOn: $viewModel.isTimeToggledOn, label: {}).toggleStyle(SwitchToggleStyle(tint: .t_action))
                    .padding(Layout.Spacing.tight)
            }
            if viewModel.isTimeToggledOn {
                VStack {
                    HStack {
                        Spacer()
                        DatePicker(String.empty, selection: $viewModel.dueTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .scaleEffect(0.85)
                            .padding(.trailing, -Layout.Spacing.spacious)
                            .padding(.vertical, -Layout.Spacing.compact)
                    }
                    HStack {
                        Text(viewModel.reminderText)
                        Spacer()
                        Toggle(isOn: $viewModel.isReminderToggledOn, label: {}).toggleStyle(SwitchToggleStyle(tint: .t_action))
                            .padding(Layout.Spacing.tight)
                    }
                }
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
