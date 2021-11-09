//
//  SimpleTextFieldStyle.swift
//  TasKit
//
//  Created by Kyle Dold on 19/02/2021.
//

import SwiftUI

public struct SimpleTextFieldStyle : TextFieldStyle {
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        VStack() {
            configuration
                .padding(10)
                .background(Color.t_input_background)
                .cornerRadius(10)
        }
    }
}
