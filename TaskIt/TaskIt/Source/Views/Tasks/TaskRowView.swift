//
//  TaskRowView.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import SwiftUI

struct TaskRowView<ViewModel: TaskRowViewModelProtocol>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - View
    
    var body: some View {
        HStack {
            
            VStack(alignment: .center) {
                Text(viewModel.dayOfTheWeekText).font(.regular_12).foregroundColor(Color.t_red)
                Text(viewModel.dateText).font(.bold_24)
                Text(viewModel.monthText).font(.regular_14)
            }.frame(minWidth: 40)
            
            
            Rectangle()
                .foregroundColor(.primary)
                .frame(width: 0.2)
            
            Text(viewModel.titleText)
                .font(.regular_16)
                .foregroundColor(.primary)
            
            Spacer()
            
            if viewModel.priority != .none {
                VStack {
                    Image(Image.iconNameForPriority(viewModel.priority))
                        .resizable()
                        .frame(width: 20, height: 20)
                    Spacer()
                }
            }
        }
        .padding(.all,  Layout.Padding.compact)
        .background(Color.t_content_background)
        .cornerRadius(25.0)
        .shadow(color: Color.black.opacity(0.4), radius: 1, y: 1)
        .padding(.horizontal, Layout.Padding.compact)
    }
}

// MARK: - PreviewProvider -

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskRowView(viewModel: FakeTaskRowViewModel())
                .previewLayout(.fixed(width: 300, height: 80))
        }
    }
}
