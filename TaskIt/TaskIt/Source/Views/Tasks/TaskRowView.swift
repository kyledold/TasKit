//
//  TaskRowView.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import SwiftUI

struct TaskRowView<ViewModel: TaskRowViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            
            VStack(alignment: .center) {
                Text("25").font(.title20)
                Text("Nov").font(.body14)
            }
            
            Rectangle()
                .foregroundColor(.primary)
                .frame(width: 0.2)
            
            Text(viewModel.titleText)
                .font(.body16)
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
        .padding(.all, 12)
        .background(Color.t_content_background)
        .cornerRadius(25.0)
        .shadow(color: Color.black.opacity(0.4), radius: 1, y: 1)
        .padding(.horizontal, 8)
    }
}


struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskRowView(viewModel: FakeTaskRowViewModel())
                .previewLayout(.fixed(width: 300, height: 80))
        }
    }
}
