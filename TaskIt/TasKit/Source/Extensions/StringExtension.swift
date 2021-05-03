//
//  StringExtension.swift
//  TasKit
//
//  Created by Kyle Dold on 16/02/2021.
//

import Foundation

extension String {
    
    static let empty = ""
    
    var isBlank: Bool { allSatisfy { $0.isWhitespace } }
}
