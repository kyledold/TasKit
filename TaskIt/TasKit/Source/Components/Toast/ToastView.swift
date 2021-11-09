//
//  ToastView.swift
//  TasKit
//
//  Created by Kyle Dold on 23/02/2021.
//

import SwiftUI

public struct ToastView<ToastContent>: ViewModifier where ToastContent: View {
    
    // MARK: - Properties
    
    @Binding var isPresented: Bool
    
    let animation = Animation.easeOut(duration: 0.3)
    let autohideDuration = 3.0
    let closeOnTap = true
    let closeOnTapOutside = false
    var onTap: () -> Void
    var view: () -> ToastContent
    var dispatchWorkHolder = DispatchWorkHolder()
    
    @State private var presenterContentRect: CGRect = .zero
    @State private var sheetContentRect: CGRect = .zero
    
    private var displayedOffset: CGFloat {
        return -presenterContentRect.midY + sheetContentRect.height/2
    }
    
    private var hiddenOffset: CGFloat {
        if presenterContentRect.isEmpty {
            return -1000
        }
        return -presenterContentRect.midY - sheetContentRect.height/2 - 5
    }
    
    private var currentOffset: CGFloat {
        return isPresented ? displayedOffset : hiddenOffset
    }
    
    private var screenHeight: CGFloat {
        #if os(watchOS)
        return WKInterfaceDevice.current().screenBounds.size.height
        #elseif os(iOS)
        return UIScreen.screenHeight
        #elseif os(macOS)
        return NSScreen.main?.frame.height ?? 0
        #endif
    }
    
    private var screenWidth: CGFloat {
        #if os(watchOS)
        return WKInterfaceDevice.current().screenBounds.size.width
        #elseif os(iOS)
        return UIScreen.screenWidth
        #elseif os(macOS)
        return NSScreen.main?.frame.width ?? 0
        #endif
    }
    
    // MARK: - Content Builders
    
    public func body(content: Content) -> some View {
        content
            .applyIf(closeOnTapOutside) {
                $0.simultaneousGesture( TapGesture().onEnded {
                    isPresented = false
                })
        }
        .background(
            GeometryReader { proxy -> AnyView in
                let rect = proxy.frame(in: .global)
                if rect.integral != presenterContentRect.integral {
                    DispatchQueue.main.async {
                        presenterContentRect = rect
                    }
                }
                return AnyView(EmptyView())
            }
        ).overlay(presentSheet())
    }
    
    func presentSheet() -> some View {
        
        // dispatch autohide and cancel previous one
        dispatchWorkHolder.work?.cancel()
        dispatchWorkHolder.work = DispatchWorkItem(block: {
            isPresented = false
        })
        
        if isPresented,
           let work = dispatchWorkHolder.work {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + autohideDuration, execute: work)
        }
        
        return ZStack {
            Group {
                VStack {
                    VStack {
                        view()
                            .simultaneousGesture(TapGesture().onEnded {
                                if closeOnTap {
                                    isPresented = false
                                    onTap()
                                }
                            })
                            .background(
                                GeometryReader { proxy -> AnyView in
                                    let rect = proxy.frame(in: .global)
                                    if rect.integral != sheetContentRect.integral {
                                        DispatchQueue.main.async {
                                            sheetContentRect = rect
                                        }
                                    }
                                    return AnyView(EmptyView())
                                }
                        )
                    }
                }
                .frame(width: screenWidth)
                .offset(x: 0, y: currentOffset)
                .animation(animation)
            }
        }
    }
}

class DispatchWorkHolder {
    var work: DispatchWorkItem?
}
