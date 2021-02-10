//
//  WelcomeView.swift
//  TaskIt
//
//  Created by Kyle Dold on 31/01/2021.
//

import SwiftUI

struct WelcomeView: View {
    
    var viewModel: WelcomeViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: Layout.Padding.cozy) {
                Spacer()
                
                Text(viewModel.welcomeText)
                    .font(.title)
                    .foregroundColor(.white)
                
                Image("Placeholder", bundle: .main)
                    .resizable()
                    .frame(width: 200, height: 130)
                
                Spacer()

                NavigationLink(destination: TabBarView()) {
                   Text(viewModel.getStartedButtonText)
                }.simultaneousGesture(TapGesture().onEnded {
                    viewModel.onGetStartedTapped()
                })
                .buttonStyle(FilledButtonStyle())
                
                Text(viewModel.disclaimerText)
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
        WelcomeView(viewModel: .init())
    }
}
