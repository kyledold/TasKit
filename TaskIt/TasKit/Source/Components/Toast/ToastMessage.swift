//
//  ToastMessage.swift
//  TasKit
//
//  Created by Kyle Dold on 23/02/2021.
//

import SwiftUI

extension View {
    
    public func present<ToastMessage: View>(
        isPresented: Binding<Bool>,
        onTap: (() -> Void)? = nil,
        view: @escaping () -> ToastMessage
    ) -> some View {
        
        modifier(
            ToastView(
                isPresented: isPresented,
                onTap: onTap ?? {},
                view: view
            )
        )
    }
    
    func applyIf<T: View>(_ condition: @autoclosure () -> Bool, apply: (Self) -> T) -> AnyView {
        if condition() {
            return AnyView(apply(self))
        } else {
            return AnyView(self)
        }
    }
}
