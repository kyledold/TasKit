//
//  TaskDetailsView.swift
//  TaskIt
//
//  Created by Kyle Dold on 20/02/2021.
//

import SwiftUI

struct TaskDetailsView<ViewModel: TaskDetailsViewModelProtocol>: View {
    
    var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView()
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        if viewModel.priority != .none {
                            Image(Image.iconNameForPriority(viewModel.priority))
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        
                        HStack(spacing: Layout.Padding.cozy) {
                            Text(viewModel.titleText)
                                .font(.title20)
                                .foregroundColor(.primary)
                            
                            Spacer()
                        }
                    }.padding().padding(.bottom, 72)
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight - 90)
                .background(Color.t_content_background)
                .cornerRadius(25)
            }
            .edgesIgnoringSafeArea(.bottom)
            
            ButtonFooterView(
                buttonText: "Complete task",
                buttonColor: .t_green,
                onButtonTap: {
                }
            )
        }
        .backgroundOverlay()
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsView(viewModel: FakeTaskDetailsViewModel())
    }
}

private struct HeaderView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack(spacing: 18) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.down")
                Text("cancel")
                    .font(.title20)
            })
            .foregroundColor(.t_white)
            Spacer()
            Button(action: {
                
            }, label: {
                Image(systemName: Image.Icons.pencil).iconStyle()
            })
            Button(action: {
                
            }, label: {
                Image(systemName: Image.Icons.delete).iconStyle()
            })
        }
        .padding().padding(.top, 32)
    }
}
