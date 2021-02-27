//
//  TextBox.swift
//  TaskIt
//
//  Created by Kyle Dold on 27/02/2021.
//

import SwiftUI

struct TextBox: View {
    
    private let placeholder: String
    @Binding var text: String
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            TextEditor(text: $text)
                .frame(minHeight: 100)
                .padding(Layout.Padding.tight)
                .background(Color.t_input_background)
                .cornerRadius(10)
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(.horizontal, Layout.Padding.compact)
                    .padding(.vertical, 12)
            }
        }
    }
}

extension String {

}

