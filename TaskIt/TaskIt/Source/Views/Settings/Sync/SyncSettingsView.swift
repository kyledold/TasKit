//
//  SyncSettingsView.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/04/2021.
//

import SwiftUI

struct SyncSettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .leading, spacing: Layout.Spacing.cozy) {
            List {
                
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationBarTitle("TasKit Sync")
    }
}

struct SyncSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SyncSettingsView()
    }
}
