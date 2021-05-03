//
//  CheckBox.swift
//  TasKit
//
//  Created by Kyle Dold on 05/04/2021.
//

import SwiftUI

struct CheckBox: View {
    
    @Binding var isChecked: Bool
    
    private let hapticFeedbackGenerator = UINotificationFeedbackGenerator()
    
    var body: some View {
        Button(action: buttonAction) {
            Image(systemName: isChecked ? Image.Icons.tickedCheckBox : Image.Icons.unTickedCheckBox)
                .resizable()
                .frame(width: 22, height: 22)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func buttonAction() {
        isChecked.toggle()
        hapticFeedbackGenerator.notificationOccurred(.success)
    }
}
