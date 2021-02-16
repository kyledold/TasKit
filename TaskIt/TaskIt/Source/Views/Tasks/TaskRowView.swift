//
//  TaskRowView.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import SwiftUI

struct TaskRowView<ViewModel: TaskRowViewModelProtocol>: View {
    
    var viewModel: ViewModel

    var body: some View {
        HStack(spacing: Layout.Padding.cozy) {
            Rectangle()
                .fill(Color.orange)
                .frame(width: 15)
            
            Text(viewModel.titleText)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .frame(height: 70)
        .listRowInsets(EdgeInsets())
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
