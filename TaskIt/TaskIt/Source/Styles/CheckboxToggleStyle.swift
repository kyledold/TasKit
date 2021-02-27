//
//  CheckboxToggleStyle.swift
//  TaskIt
//
//  Created by Kyle Dold on 27/02/2021.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            configuration.label
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 22, height: 22)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}
