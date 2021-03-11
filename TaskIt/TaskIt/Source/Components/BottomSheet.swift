//
//  BottomSheet.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/03/2021.
//

import SwiftUI

public struct BottomSheet<Content: View>: View {
    
    // MARK: - Properties
    
    @Binding var isPresented: Bool
    
    @State private var draggedOffset: CGFloat = 0
    @State private var previousDragValue: DragGesture.Value?
    
    private var dragToDismissThreshold: CGFloat { height * 0.2 }
    
    private let content: Content
    private let height: CGFloat
    private let topBarCornerRadius = CGFloat(10)
    private let contentBackgroundColor = Color.t_input_background
    private let topBarBackgroundColor = Color.t_input_background
    
    // MARK: - Initialisation
    
    public init(
        isPresented: Binding<Bool>,
        height: CGFloat,
        @ViewBuilder content: () -> Content
    ) {
        self._isPresented = isPresented
        self.height = height
        self.content = content()
    }
    
    // MARK: - View
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                DimmedBackgroundView(isPresented: $isPresented)
                VStack(spacing: Layout.Padding.compact) {
                    topBar(geometry: geometry)
                    content
                }
                .frame(height: height)
                .background(contentBackgroundColor)
                .cornerRadius(topBarCornerRadius, corners: [.topLeft, .topRight])
                .animation(.interactiveSpring())
                .offset(y: yOffset(for: isPresented, geometry: geometry))
            }
        }
    }
    
    private func topBar(geometry: GeometryProxy) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.secondary)
                .frame(width: 40, height: 6)
        }
        .frame(width: geometry.size.width, height: 30)
        .background(topBarBackgroundColor)
        .gesture(
            DragGesture().onChanged { value in
                    
                let offsetY = value.translation.height
                draggedOffset = offsetY
                
                if let previousValue = previousDragValue {
                    let previousOffsetY = previousValue.translation.height
                    let timeDiff = Double(value.time.timeIntervalSince(previousValue.time))
                    let heightDiff = Double(offsetY - previousOffsetY)
                    let velocityY = heightDiff / timeDiff
                    if velocityY > 1400 {
                        isPresented = false
                        return
                    }
                }
                previousDragValue = value
            }
            .onEnded { value in
                let offsetY = value.translation.height
                
                if offsetY > dragToDismissThreshold {
                    isPresented = false
                }
                
                draggedOffset = 0
            }
        )
    }
    
    // MARK: - Convenience
    
    private func yOffset(for isPresented: Bool, geometry: GeometryProxy) -> CGFloat {
        if isPresented {
            return geometry.size.height/2 - height/2 + geometry.safeAreaInsets.bottom + draggedOffset
        } else {
            return geometry.size.height/2 + height/2 + geometry.safeAreaInsets.bottom
        }
    }
}
