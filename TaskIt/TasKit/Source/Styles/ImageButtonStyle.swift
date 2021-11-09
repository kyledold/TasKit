//
//  ImageButtonStyle.swift
//  TasKit
//
//  Created by Kyle Dold on 06/03/2021.
//

import SwiftUI

struct ImageButtonStyle: ButtonStyle {
    
    var isDisabled: Bool = false
    var buttonColor: Color = .primary
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(buttonColor)
            .opacity(isDisabled ? 0.4 : 1)
    }
}
