//
//  ViewExtension.swift
//  TaskIt
//
//  Created by Kyle Dold on 20/02/2021.
//

import SwiftUI
import Foundation

extension View {

    func onNotification(
        _ notificationName: Notification.Name,
        perform action: @escaping () -> Void
    ) -> some View {
        onReceive(NotificationCenter.default.publisher(for: notificationName)) { _ in
            action()
        }
    }
    
    func backgroundOverlay(color: Color = .t_background) -> some View {
        ZStack {
            color.ignoresSafeArea(.all)
            self
        }
    }
    
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
