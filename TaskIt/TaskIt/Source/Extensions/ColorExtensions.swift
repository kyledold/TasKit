//
//  Color.swift
//  TaskIt
//
//  Created by Kyle Dold on 31/01/2021.
//

import SwiftUI

extension Color {
    
    static let cyanBlue = Color(#colorLiteral(red: 0.2031033635, green: 0.3637996912, blue: 0.65155375, alpha: 1))
    static let t_dim_blue = Color("t_dim_blue")
    static let t_green = Color("t_green")
    static let t_yellow = Color("t_yellow")
    static let t_red = Color("t_red")
    static let t_input_background = Color("t_input_background")
    static let t_content_background = Color("t_content_background")
    static let t_background = Color("t_background")
    static let t_white = Color("t_white")
    
    static func color(for priority: Priority) -> Color {
        switch priority {
        case .none: return .clear
        case .low: return .t_green
        case .medium: return .t_yellow
        case .high: return .t_red
        }
    }
}
