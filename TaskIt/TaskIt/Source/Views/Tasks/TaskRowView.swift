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
        VStack(alignment: .leading) {
            if viewModel.priority != .none {
                Image(Image.iconNameForPriority(viewModel.priority))
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            
            HStack(spacing: Layout.Padding.cozy) {
                Text(viewModel.titleText)
                    .font(.body16)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            Spacer()
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
