//
//  PrioritySegmentView.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import SwiftUI
import Foundation

struct PrioritySegmentView: View {
    
    @Binding var selectedPriority: Priority
    @State private var backgroundColor = Color.inputBackgroundColor

    var body: some View {
        
        let binding = Binding<Priority>(
            get: { self.selectedPriority },
            set: { self.selectedPriority = $0 }
        )
        
        Picker(selection: binding, label: Text("Priority")) {
            Text(LocalizedStringKey("priority_picker.none")).tag(Priority.none)
            Text(LocalizedStringKey("priority_picker.low")).tag(Priority.low)
            Text(LocalizedStringKey("priority_picker.medium")).tag(Priority.medium)
            Text(LocalizedStringKey("priority_picker.high")).tag(Priority.high)
        }
            .onChange(of: selectedPriority) { onChange(value: $0) }
            .background(backgroundColor)
            .cornerRadius(5)
            .pickerStyle(SegmentedPickerStyle())
    }
    
    private func onChange(value: Priority) {
        switch value {
        case .none: backgroundColor = Color.inputBackgroundColor
        case .low: backgroundColor = Color.lowPriorityGreen
        case .medium: backgroundColor = Color.mediumPriorityYellow
        case .high: backgroundColor = Color.highPriorityRed
        }
    }
}

struct PriorityPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PrioritySegmentView(selectedPriority: .constant(.none))
            .previewLayout(.fixed(width: 350, height: 50))
    }
}
