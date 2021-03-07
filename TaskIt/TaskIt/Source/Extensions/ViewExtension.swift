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
    
    func onNavigation(_ action: @escaping EmptyClosure) -> some View {
        let isActive = Binding(
            get: { false },
            set: { newValue in
                if newValue {
                    action()
                }
            }
        )
        
        return NavigationLink(destination: EmptyView(), isActive: isActive) { self }
    }

    func navigation<Item, Destination: View>(item: Binding<Item?>, @ViewBuilder destination: (Item) -> Destination) -> some View {
        let isActive = Binding(
            get: { item.wrappedValue != nil },
            set: { value in
                if !value {
                    item.wrappedValue = nil
                }
            }
        )
        
        return navigation(isActive: isActive) { item.wrappedValue.map(destination) }
    }

    func navigation<Destination: View>(isActive: Binding<Bool>, @ViewBuilder destination: () -> Destination) -> some View {
        overlay(
            NavigationLink(
                destination: isActive.wrappedValue ? destination() : nil,
                isActive: isActive,
                label: { EmptyView() }
            )
        )
    }
}
