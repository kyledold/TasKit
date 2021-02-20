//
//  ViewExtension.swift
//  TaskIt
//
//  Created by Kyle Dold on 20/02/2021.
//

import SwiftUI

extension View {
    
    func backgroundOverlay(color: Color = .t_background) -> some View {
        ZStack {
            color.ignoresSafeArea(.all)
            self
        }
    }
    
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
