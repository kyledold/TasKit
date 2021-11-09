//
//  DimmedBackgroundView.swift
//  TasKit
//
//  Created by Kyle Dold on 11/03/2021.
//

import SwiftUI

struct DimmedBackgroundView: View {
    
    @Binding var isPresented: Bool
    
    @State private var draggedOffset: CGFloat = 0
    
    private var grayBackgroundOpacity: Double { isPresented ? (0.3 - Double(draggedOffset)/600) : 0 }
    
    var body: some View {
        Color
            .black
            .opacity(grayBackgroundOpacity)
            .edgesIgnoringSafeArea(.all)
            .animation(.interactiveSpring())
            .onTapGesture { isPresented = false }
    }
}
