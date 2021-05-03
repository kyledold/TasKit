//
//  UIApplicationExtension.swift
//  TasKit
//
//  Created by Kyle Dold on 13/02/2021.
//

import UIKit

extension UIApplication {
    
    static func openURL(_ url: URL) {
        guard UIApplication.shared.canOpenURL(url) else { return }
        
        print("UIApplication: openURL \(url.absoluteString)")
        UIApplication.shared.open(url)
    }
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
