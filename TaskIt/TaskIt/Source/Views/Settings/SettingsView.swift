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
                Section(footer: footer) {
                    NavigationLink(destination: ListBehaviourView(), label: {
                        Text(viewModel.listBehaviourText)
                    })
                    NavigationLink(destination: SyncSettingsView(), label: {
                        Text(viewModel.syncText)
                    })
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
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: FakeSettingsViewModel())
    }
}
