//
//  FullWidthButtonStyle.swift
//  TaskIt
//
//  Created by Kyle Dold on 26/02/2021.
//

import SwiftUI

struct FullWidthButtonStyle: ButtonStyle {
    
    var isDisabled: Bool
    var buttonColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .font(.semiBold_20)
            .foregroundColor(.white)
            .padding(.vertical, Layout.Spacing.compact)
            .background(isDisabled ? Color.t_gray : buttonColor)
            .opacity(configuration.isPressed ? 0.75 : 1.0)
    }
}

