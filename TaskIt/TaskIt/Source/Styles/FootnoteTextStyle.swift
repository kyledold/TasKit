//
//  FootnoteTextStyle.swift
//  TaskIt
//
//  Created by Kyle Dold on 02/02/2021.
//

import SwiftUI

struct FootnoteTextStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
    }
}

