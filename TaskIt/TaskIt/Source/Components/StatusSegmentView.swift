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
        
        let binding = Binding<Int>(
            get: { Int(self.selectedStatus.rawValue) },
            set: { self.selectedStatus = Status(rawValue: Int32($0))! }
        )
        
        SegmentPicker(items: ["Todo", "Completed"], selection: binding)
    }
}

struct StatusSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        StatusSegmentView(selectedStatus: .constant(.todo))
            .previewLayout(.fixed(width: 350, height: 50))
    }
}
