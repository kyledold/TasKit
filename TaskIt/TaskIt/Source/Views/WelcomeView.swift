//
//  WelcomeView.swift
//  TaskIt
//
//  Created by Kyle Dold on 31/01/2021.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing: Layout.Padding.cozy) {
                Spacer()
                
                Text(LocalizedStringKey("welcome.welcome"))
                    .font(.title)
                    .foregroundColor(.white)
                
                Image("Placeholder", bundle: .main)
                    .resizable()
                    .frame(width: 200, height: 130)
                
                Spacer()

                NavigationLink(destination: TabBarView()) {
                   Text(LocalizedStringKey("welcome.get_started"))
                }.buttonStyle(FilledButtonStyle())
                
                Text(LocalizedStringKey("welcome.terms_and_conditions"))
                    .modifier(FootnoteTextStyle())
                
                Spacer()
            }
            .padding(.horizontal, Layout.Padding.spacious)
            .background(Color.cyanBlue).ignoresSafeArea(.all)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
