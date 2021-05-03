//
//  SyncSettingsView.swift
//  TasKit
//
//  Created by Kyle Dold on 11/04/2021.
//

import SwiftUI

struct SyncSettingsView<ViewModel: SyncSettingsViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .leading, spacing: Layout.Spacing.cozy) {
            List {
                iCloudSyncSection
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationBarTitle(viewModel.titleText)
    }
}

extension SyncSettingsView {
    
    private var iCloudSyncSection: some View {
        Section(footer: iCloudSyncSectionFooter) {
            HStack {
                Toggle(isOn: $viewModel.isICloudSyncEnabled) {
                    Text(viewModel.iCloudSyncText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .toggleStyle(SwitchToggleStyle(tint: .t_action))
            }
            .frame(height: 40)
        }
    }
    
    private var iCloudSyncSectionFooter: some View {
        Text(viewModel.iCloudSyncDescription)
            .padding(.horizontal)
    }
}

struct SyncSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SyncSettingsView(viewModel: FakeSyncSettingsViewModel())
    }
}
