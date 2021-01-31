//
//  OutlinedButtonStyle.swift
//  TaskIt
//
//  Created by Kyle Dold on 02/02/2021.
//

import SwiftUI

struct OutlinedButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.body.bold())
            .padding()
            .frame(maxWidth: .infinity)
            .border(Color.white)
            .foregroundColor(.white)
            .background(Color.white.opacity(
                configuration.isPressed ? 0.5 : 0
            ))
    }
}
