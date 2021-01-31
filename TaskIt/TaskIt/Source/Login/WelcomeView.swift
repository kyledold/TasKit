//
//  WelcomeView.swift
//  TaskIt
//
//  Created by Kyle Dold on 31/01/2021.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        VStack(spacing: Layout.Padding.cozy) {
            Spacer()
            
            Text(LocalizedStringKey("welcome.welcome"))
                .font(.title)
                .foregroundColor(.white)
            
            Image("Placeholder", bundle: .main)
                .resizable()
                .frame(width: 200, height: 130)
            
            Spacer()
            
            Button(LocalizedStringKey("welcome.sign_in")) {}
                .buttonStyle(FilledButtonStyle())
            Button(LocalizedStringKey("welcome.crate_account")) {}
                .buttonStyle(OutlinedButtonStyle())
            
            Text(LocalizedStringKey("welcome.terms_and_conditions"))
                .modifier(FootnoteTextStyle())
            
            Spacer()
        }
        .padding(.horizontal, Layout.Padding.cozy)
        .background(Color.cyanBlue).ignoresSafeArea(.all)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
