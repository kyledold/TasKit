//
//  TextNavigationButtonStyle.swift
//  TaskIt
//
//  Created by Kyle Dold on 26/02/2021.
//

import SwiftUI

struct TextNavigationButtonStyle: ButtonStyle {
    
    var buttonColor: Color
    var textColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(5)
            .padding(.horizontal, 5)
            .font(.regular_16)
            .foregroundColor(textColor)
            .background(buttonColor)
            .cornerRadius(10)
            .opacity(configuration.isPressed ? 0.50 : 1.0)
    }
}

