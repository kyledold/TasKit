//
//  ButtonFooterView.swift
//  TaskIt
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
            Button(action: { onButtonTap() }, label: { Text(buttonText).frame(minWidth: 120).padding(.vertical, 5) })
                .font(.semiBold_20)
                .foregroundColor(.white)
                .padding(.vertical, Layout.Padding.compact).padding(.horizontal)
                .background(buttonColor)
                .cornerRadius(25)
                .padding(.bottom, Layout.Padding.luxurious)
                
        }.ignoresSafeArea(.all)
    }
}

struct ButtonFooterView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonFooterView(buttonText: "Title", buttonColor: .t_green, onButtonTap: {})
    }
}
