//
//  RoundedButtonStyle.swift
//  TaskIt
//
//  Created by Kyle Dold on 26/02/2021.
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    
    var buttonColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 120).padding(.vertical, 5)
            .font(.medium_22)
            .foregroundColor(.white)
            .padding(.vertical, Layout.Spacing.compact).padding(.horizontal)
            .background(buttonColor)
            .cornerRadius(25)
            .opacity(configuration.isPressed ? 0.75 : 1)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

