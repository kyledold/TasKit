//
//  AddTaskView.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import SwiftUI

struct AddTaskView<ViewModel: AddTaskViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            VStack {
                HeaderSection()
                ScrollView {
                    addTaskView
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight - 90)
                .background(Color.t_content_background)
                .cornerRadius(25)
            }
            .edgesIgnoringSafeArea(.bottom)
            
            ButtonFooterView(
                buttonText: "Create",
                buttonColor: .t_green,
                onButtonTap: {
                    viewModel.addNewTaskTapped() {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
        .backgroundOverlay()
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    private var addTaskView: some View {
        VStack(spacing: Layout.Padding.cozy) {
            VStack(spacing: Layout.Padding.cozy) {
                
                TextField(viewModel.taskNamePlaceholderText, text: $viewModel.taskName)
                    .textFieldStyle(SimpleTextFieldStyle())
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                
                PrioritySegmentView(selectedPriority: $viewModel.priority)
                
                DatePicker(viewModel.taskDateText, selection: $viewModel.dueDate, displayedComponents: .date)
                    .accentColor(Color.primary)
                
                Spacer()
            }
        }.padding().padding(.bottom, Layout.Padding.luxurious)
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(viewModel: FakeAddTaskViewModel())
    }
}
