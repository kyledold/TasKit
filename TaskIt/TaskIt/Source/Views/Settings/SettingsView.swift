//
//  SettingsView.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

import SwiftUI

struct SettingsView<ViewModel: SettingsViewModelProtocol>: View {
    
    var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .leading, spacing: Layout.Spacing.cozy) {
            List {
                Section {
                    ForEach(viewModel.preferencesViewModels, id: \.self) { settingsItem in
                        Text(settingsItem.text)
                    }
                }
                Section(footer: footer) {
                    ForEach(viewModel.footerViewModels, id: \.self) { settingsItem in
                        Text(settingsItem.text)
                    }
                }
                
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationBarTitle(viewModel.titleText)
        .navigationBarItems(leading:
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: { Text("Done") })
        )
    }
    
    var footer: some View {
        viewModel.versionNumber
            .map { Text("app.version.\($0)") }
            .modifier(FooterStyle())
    }
    
    private func didTapSettingsRow(_ rowViewModel: SettingsItem) {
        //UIApplication.openURL(rowViewModel.url)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: FakeSettingsViewModel())
    }
}
