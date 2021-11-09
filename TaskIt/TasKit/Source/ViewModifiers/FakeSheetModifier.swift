//
//  FakeSheetModifier.swift
//  TasKit
//
//  Created by Kyle Dold on 07/03/2021.
//

import SwiftUI

// This is just to make "PreviewProvider" conformance less messy
struct FakeSheetModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
    }
}
