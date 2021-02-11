//
//  WelcomeView.swift
//  TaskIt
//
//  Created by Kyle Dold on 31/01/2021.
//

import SwiftUI

struct WelcomeView<ViewModel: WelcomeViewModelProtocol>: View {
    
    var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: Layout.Padding.cozy) {
                Spacer()
                
                Text(LocalizedStringKey(viewModel.welcomeTextKey))
                    .font(.title)
                    .foregroundColor(.white)
                
                Image("Placeholder", bundle: .main)
                    .resizable()
                    .frame(width: 200, height: 130)
                
                Spacer()

                NavigationLink(destination: TabBarView()) {
                    Text(LocalizedStringKey(viewModel.getStartedButtonTextKey))
                }.simultaneousGesture(TapGesture().onEnded {
                    viewModel.onGetStartedTapped()
                })
                .buttonStyle(FilledButtonStyle())
                
                Text(LocalizedStringKey(viewModel.disclaimerTextKey))
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
        WelcomeView<FakeWelcomeViewModel>(viewModel: FakeWelcomeViewModel())
    }
}
