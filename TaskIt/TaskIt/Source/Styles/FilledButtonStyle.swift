//
//  FilledButtonStyle.swift
//  TaskIt
//
//  Created by Kyle Dold on 31/01/2021.
//

import SwiftUI

struct FilledButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.body.bold())
            .padding()
            .frame(maxWidth: .infinity)
            .border(Color.white)
            .foregroundColor(.cyanBlue)
            .background(Color.white.opacity(
                configuration.isPressed ? 0.5 : 1
            ))
    }
}

