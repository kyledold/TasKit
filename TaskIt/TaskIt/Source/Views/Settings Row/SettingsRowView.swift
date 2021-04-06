//
//  SettingsRowView.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

import SwiftUI

struct SettingsRowView<ViewModel: SettingsRowViewModelProtocol>: View {

    var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 3.0) {
            Text(viewModel.titleText)
                .font(.body)
                .foregroundColor(.primary)

            Text(viewModel.subtitleText)
                .modifier(SubTitleStyle())
        }
        .padding(.vertical, 5.0)
    }
}


struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(viewModel: FakeSettingsRowViewModel())
                .previewLayout(.fixed(width: 300, height: 80))
    }
}
