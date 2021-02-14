//
//  SettingsView.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

import SwiftUI

struct SettingsView<ViewModel: SettingsViewModelProtocol>: View {
    
    var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                List {
                    Section(footer: footer) {
                        ForEach(viewModel.rowViewModels, id: \.id) { settingsRowViewModel in
                            Button(action: { didTapSettingsRow(settingsRowViewModel) }) {
                                SettingsRowView(viewModel: settingsRowViewModel)
                            }
                        }
                    }
                    
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationBarTitle(LocalizedStringKey(viewModel.titleTextKey))
        }
    }
    
    var footer: some View {
        viewModel.versionNumber
            .map { Text("app.version.\($0)") }
            .modifier(FooterStyle())
    }
    
    private func didTapSettingsRow(_ rowViewModel: SettingsRowViewModel) {
        UIApplication.openURL(rowViewModel.url)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: FakeSettingsViewModel())
    }
}