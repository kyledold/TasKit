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
    
    @ViewBuilder
    func onNavigation(_ action: @escaping EmptyClosure) -> some View {
        let isActive = Binding(
            get: { false },
            set: { newValue in
                if newValue {
                    action()
                }
            }
        )
        
        // TODO: this is to hide navigation link arrow, try find a better solution
        ZStack {
            NavigationLink(destination: EmptyView(), isActive: isActive) {}
            self
        }
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
    
    func bottomSheet<Content: View>(
            isPresented: Binding<Bool>,
            height: CGFloat,
            topBarHeight: CGFloat = 30,
            topBarCornerRadius: CGFloat? = nil,
            contentBackgroundColor: Color = Color(.systemBackground),
            topBarBackgroundColor: Color = Color(.systemBackground),
            showTopIndicator: Bool = true,
            @ViewBuilder content: @escaping () -> Content
        ) -> some View {
            ZStack {
                self
                BottomSheet(isPresented: isPresented,
                            height: height,
                            topBarHeight: topBarHeight,
                            topBarCornerRadius: topBarCornerRadius,
                            topBarBackgroundColor: topBarBackgroundColor,
                            contentBackgroundColor: contentBackgroundColor,
                            showTopIndicator: showTopIndicator,
                            content: content)
            }
        }
}
