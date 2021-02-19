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
    @State private var backgroundColor = Color.inputBackgroundColor

    var body: some View {
        
        let binding = Binding<Status>(
            get: { self.selectedStatus },
            set: { self.selectedStatus = $0 }
        )
        
        Picker(selection: binding, label: Text("Status")) {
            Text(LocalizedStringKey("status_picker.todo")).tag(Status.todo)
            Text(LocalizedStringKey("status_picker.completed")).tag(Status.completed)
        }
            .onChange(of: selectedStatus) { onChange(value: $0) }
            .background(backgroundColor)
            .pickerStyle(SegmentedPickerStyle())
    }
    
    private func onChange(value: Status) {
        switch value {
        case .todo: backgroundColor = Color.inputBackgroundColor
        case .completed: backgroundColor = Color.cyanBlue
        }
    }
}

struct StatusSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        PrioritySegmentView(selectedPriority: .constant(.none))
            .previewLayout(.fixed(width: 350, height: 50))
    }
}
