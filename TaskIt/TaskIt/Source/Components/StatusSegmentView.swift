//
//  StatusSegmentView.swift
//  TaskIt
//
//  Created by Kyle Dold on 19/02/2021.
//

import SwiftUI
import Foundation

struct StatusSegmentView: View {
    
    @Binding var selectedStatus: Status

    var body: some View {
        
        let binding = Binding<Status>(
            get: { self.selectedStatus },
            set: { self.selectedStatus = $0 }
        )
        
        Picker(selection: binding, label: Text("Status")) {
            Text(LocalizedStringKey("status_picker.todo")).tag(Status.todo)
            Text(LocalizedStringKey("status_picker.completed")).tag(Status.completed)
        }
        .background(Color.t_input_background)
        .padding(.horizontal, Layout.Padding.compact)
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct StatusSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        StatusSegmentView(selectedStatus: .constant(.todo))
            .previewLayout(.fixed(width: 350, height: 50))
    }
}
