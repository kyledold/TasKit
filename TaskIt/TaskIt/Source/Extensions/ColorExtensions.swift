//
//  Color.swift
//  TaskIt
//
//  Created by Kyle Dold on 31/01/2021.
//

import SwiftUI

extension Color {
    
    static let cyanBlue = Color(#colorLiteral(red: 0.2031033635, green: 0.3637996912, blue: 0.65155375, alpha: 1))
    
    static func color(for priority: Priority) -> Color {
        switch priority {
        case .none: return .clear
        case .low: return Color("LowPriorityGreen")
        case .medium: return Color("MediumPriorityYellow")
        case .high: return Color("HighPriorityRed")
        }
    }
}
