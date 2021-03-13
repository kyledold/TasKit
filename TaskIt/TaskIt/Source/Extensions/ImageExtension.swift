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
        static let sort = "arrow.up.arrow.down.square"
        static let circleTick = "checkmark.circle"
        static let tick = "checkmark"
    }
    
    func iconStyle() -> some View {
        self.resizable()
            .frame(width: 25, height: 25)
            .foregroundColor(.primary)
    }
    
    func placeholderStyle() -> some View {
        self.resizable()
            .frame(width: 40, height: 40)
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

