//
//  ButtonFooterView.swift
//  TasKit
//
//  Created by Kyle Dold on 21/02/2021.
//

import SwiftUI

struct ButtonFooterView: View {
    
    var buttonText: String
    var buttonColor: Color
    var onButtonTap: EmptyClosure
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                onButtonTap()
            }, label: {
                Text(buttonText)
            })
            .buttonStyle(RoundedButtonStyle(buttonColor: buttonColor))
            .padding(.bottom, Layout.Spacing.luxurious)
        }.ignoresSafeArea(.all)
    }
}

struct ButtonFooterView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonFooterView(buttonText: "Title", buttonColor: .t_green, onButtonTap: {})
    }
}
