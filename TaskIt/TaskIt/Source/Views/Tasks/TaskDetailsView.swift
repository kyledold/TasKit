//
//  TaskDetailsView.swift
//  TaskIt
//
//  Created by Kyle Dold on 20/02/2021.
//

import SwiftUI

struct TaskDetailsView<ViewModel: TaskDetailsViewModelProtocol>: View {
    
    // MARK: - Properties
    
    var viewModel: ViewModel
    @ObservedObject var navigator: TasksNavigator
    
    @State private var showingActionSheet = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            VStack {
                navigationHeaderView
                taskDetailsBodyView
            }
            .edgesIgnoringSafeArea(.bottom)
            
            ButtonFooterView(
                buttonText: viewModel.submitButtonText,
                buttonColor: .t_green,
                onButtonTap: {
                    viewModel.submitButtonTapped {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
        .backgroundOverlay()
        .sheet(isPresented: $navigator.showSheet) {
            navigator.sheetView()
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text(viewModel.actionSheetTitle), message: Text(viewModel.actionSheetMessage), buttons: [
                .destructive(Text(viewModel.deleteText), action: {
                    viewModel.deleteButtonTapped {
                        presentationMode.wrappedValue.dismiss()
                    }
                }),
                .cancel()
            ])
        }
    }
}

extension TaskDetailsView {
    
    private var navigationHeaderView: some View {
        HStack(spacing: Layout.Padding.cozy) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: Image.Icons.downChevron)
                Text(viewModel.cancelButtonText)
                    .font(.bold_20)
            })
            .foregroundColor(.t_white)
            Spacer()
            Button(action: {
                navigator.sheetDestination = .editTask(task: viewModel.task)
            }, label: {
                Image(systemName: Image.Icons.pencil).iconStyle()
            })
            Button(action: {
                showingActionSheet = true
            }, label: {
                Image(systemName: Image.Icons.delete).iconStyle()
            })
        }
        .padding().padding(.top, Layout.Padding.spacious)
    }
    
    private var taskDetailsBodyView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                if viewModel.priority != .none {
                    Image(Image.iconNameForPriority(viewModel.priority))
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                
                HStack(spacing: Layout.Padding.cozy) {
                    Text(viewModel.titleText)
                        .font(.bold_20)
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
            }.padding().padding(.bottom, 72)
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight - 90)
        .background(Color.t_content_background)
        .cornerRadius(25)
    }
}

// MARK: - PreviewProvider -

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsView(viewModel: FakeTaskDetailsViewModel(), navigator: TasksNavigator())
    }
}
