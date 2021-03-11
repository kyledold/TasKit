//
//  ImageButtonStyle.swift
//  TaskIt
//
//  Created by Kyle Dold on 06/03/2021.
//

import SwiftUI

struct ImageButtonStyle: ButtonStyle {
    
    var isDisabled: Bool
    var buttonColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(buttonColor)
            .opacity(isDisabled ? 0.5 : 1.0)
    }
}
