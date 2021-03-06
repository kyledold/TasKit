//
//  ImageExtension.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

import SwiftUI

extension Image {
    
    struct Icons {
        static let add = "plus"
        static let close = "xmark"
        static let calendar = "calendar"
        static let settings = "gearshape.fill"
        static let tasks = "list.dash"
        static let create = "arrow.up.circle"
    }
    
    func iconStyle(foregroundColor: Color = .white) -> some View {
        self.resizable()
            .frame(width: 25, height: 25)
            .foregroundColor(foregroundColor)
    }
    
    func thumbnailImageModifier(tintColor: Color) -> some View {
        self.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 17.0, height: 17.0)
            .padding(6.0)
            .background(tintColor)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 6.0, style: .continuous))
   }
}

