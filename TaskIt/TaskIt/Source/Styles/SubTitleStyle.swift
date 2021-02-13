//
//  SubTitleStyle.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

import SwiftUI

struct SubTitleStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .foregroundColor(.secondary)
            .lineLimit(1)
    }
}
