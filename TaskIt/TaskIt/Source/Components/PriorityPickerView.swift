//
//  PriorityPickerView.swift
//  TaskIt
//
//  Created by Kyle Dold on 16/02/2021.
//

import SwiftUI

struct PriorityPickerView: View {
    
    @State private var priority: Priority = .none
    @State private var backgroundColor: Color = .gray

    var body: some View {
        Picker(selection: $priority, label: Text("Priority")) {
            Text("None").tag(Priority.none)
            Text("Low").tag(Priority.low)
            Text("Medium").tag(Priority.medium)
            Text("High").tag(Priority.high)
            
        }
            .onChange(of: priority) { onChange(value: $0) }
            .background(backgroundColor)
            .cornerRadius(5)
            .pickerStyle(SegmentedPickerStyle())
    }
    
    private func onChange(value: Priority) {
        switch value {
        case .none: backgroundColor = .gray
        case .low: backgroundColor = .green
        case .medium: backgroundColor = .yellow
        case .high: backgroundColor = .red
        }
    }
}

struct PriorityPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PriorityPickerView()
            .previewLayout(.fixed(width: 350, height: 80))
    }
}
