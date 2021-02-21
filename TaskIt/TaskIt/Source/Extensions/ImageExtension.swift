//
//  ImageExtension.swift
//  TaskIt
//
//  Created by Kyle Dold on 13/02/2021.
//

import SwiftUI

extension Image {
    
    struct Icons {
        static let calendar = "calendar"
        static let settings = "gearshape.fill"
        static let tasks = "list.dash"
        static let lowPriority = "LowPriority"
        static let mediumPriority = "MediumPriority"
        static let highPriority = "HighPriority"
    }
    
    static func iconNameForPriority(_ priority: Priority) -> String {
        switch priority {
        case .none: return .empty
        case .low: return Icons.lowPriority
        case .medium: return Icons.mediumPriority
        case .high: return Icons.highPriority
        }
    }
    func iconStyle() -> some View {
        self.resizable()
            .frame(width: 30, height: 30)
            .foregroundColor(Color.t_white)
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

