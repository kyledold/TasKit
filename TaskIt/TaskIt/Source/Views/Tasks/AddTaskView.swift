//
//  AddTaskView.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import SwiftUI

struct AddTaskView<ViewModel: AddTaskViewModelProtocol>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @State private var showtextFieldToolbar = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                addTaskView
            }
            .background(Color.t_content_background)
            .edgesIgnoringSafeArea(.bottom)
            
            footerView
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

extension AddTaskView {
    
    private var headerView: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: Image.Icons.downChevron)
                Text(viewModel.cancelButtonText)
                    .font(.bold_20)
            })
            .foregroundColor(Color.primary)
            .padding()
            Spacer()
        }
    }
    
    private var addTaskView: some View {
        ScrollView {
            VStack(spacing: Layout.Padding.cozy) {
                VStack(spacing: Layout.Padding.cozy) {
                    
                    TextField(viewModel.taskNamePlaceholderText, text: $viewModel.taskName) { isChanged in
                        if isChanged {
                            showtextFieldToolbar = true
                        }
                    } onCommit: {
                        showtextFieldToolbar = false
                    }
                    .textFieldStyle(SimpleTextFieldStyle())
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    
                    PrioritySegmentView(selectedPriority: $viewModel.priority)
                    
                    DatePicker(viewModel.taskDateText, selection: $viewModel.dueDate, displayedComponents: .date)
                        .accentColor(Color.t_black)
                    
                    Spacer()
                }
            }
            .padding().padding(.bottom, Layout.Padding.luxurious)
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
        AddTaskView(viewModel: FakeAddTaskViewModel())
    }
}
