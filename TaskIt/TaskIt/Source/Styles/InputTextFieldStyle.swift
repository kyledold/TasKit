//
//  InputTextFieldStyle.swift
//  TaskIt
//
//  Created by Kyle Dold on 15/02/2021.
//

import FloatingLabelTextFieldSwiftUI

struct InputTextFieldStyle: FloatingLabelTextFieldStyle {
    
    func body(content: FloatingLabelTextField) -> FloatingLabelTextField {
        content
            .spaceBetweenTitleText(35)
            .textAlignment(.leading)
            .lineHeight(1)
            .selectedLineHeight(1.5)
            .lineColor(.gray)
            .selectedLineColor(.accentColor)
            .titleColor(.gray)
            .selectedTitleColor(.accentColor)
            .titleFont(.body)
            .textColor(.black)
            .selectedTextColor(.accentColor)
            .textFont(.system(size: 15))
            .placeholderColor(.gray)
            .placeholderFont(.system(size: 15))
            .errorColor(.red)
    }
}
