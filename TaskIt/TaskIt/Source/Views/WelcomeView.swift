//
//  WelcomeView.swift
//  TaskIt
//
//  Created by Kyle Dold on 31/01/2021.
//

import SwiftUI

struct WelcomeView<ViewModel: WelcomeViewModelProtocol>: View {
    
    @Environment(\.presentationMode) var presentationMode

    var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: Layout.Padding.cozy) {
            Spacer()
            
            Text(viewModel.welcomeText)
                .font(.title)
                .foregroundColor(.cyanBlue)
            
            Image("Placeholder", bundle: .main)
                .resizable()
                .frame(width: 200, height: 130)
            
            Spacer()

            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text(viewModel.gotItButtonText)
            })
            .simultaneousGesture(TapGesture().onEnded {
                viewModel.onGotItTapped()
            })
            .buttonStyle(FilledButtonStyle())
            
            Text(viewModel.disclaimerText)
                .modifier(FootnoteTextStyle())
            
            Spacer()
        }
        .padding(.horizontal, Layout.Padding.spacious)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(viewModel: FakeWelcomeViewModel())
    }
}
