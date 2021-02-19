//
//  SimpleTextFieldStyle.swift
//  TaskIt
//
//  Created by Kyle Dold on 19/02/2021.
//

import SwiftUI

public struct SimpleTextFieldStyle : TextFieldStyle {
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        VStack() {
            configuration
            Rectangle()
                .frame(height: 0.5, alignment: .bottom)
                .foregroundColor(Color.secondary)
        }
    }
}
