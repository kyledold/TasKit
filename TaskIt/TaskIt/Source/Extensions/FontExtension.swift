//
//  FontExtension.swift
//  TaskIt
//
//  Created by Kyle Dold on 20/02/2021.
//

import SwiftUI

enum NunitoWeight: String {
    case regular = "Nunito-Regular"
    case bold = "Nunito-SemiBold"
    case semiBold = "Nunito-Bold"
}

extension Font {
    static var regular_16: Font { Font.nunito(weight: .regular, size: 16) }
    static var regular_14: Font { Font.nunito(weight: .regular, size: 14)}
    static var regular_12: Font { Font.nunito(weight: .regular, size: 12) }
    
    static var semiBold_22: Font { Font.nunito(weight: .semiBold, size: 22) }
    static var semiBold_20: Font { Font.nunito(weight: .semiBold, size: 20) }
    static var semiBold_16: Font { Font.nunito(weight: .semiBold, size: 16) }
    
    static var bold_24: Font { Font.nunito(weight: .bold, size: 24) }
    static var bold_20: Font { Font.nunito(weight: .bold, size: 20) }
    
    private static func nunito(weight: NunitoWeight, size: CGFloat) -> Font {
        Font.custom(weight.rawValue, size: size)
    }
}
