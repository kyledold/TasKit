//
//  ToastPresenter.swift
//  TaskIt
//
//  Created by Kyle Dold on 24/02/2021.
//

import SwiftUI

class ToastPresenter: ObservableObject {
    
    enum Toast {
        case none
        case taskCreated
        case taskCompleted
        case taskDeleted
        case taskUpdated
    }
    
    // MARK: - Properties
    
    var toast: Toast = .none {
        didSet {
            showToast = true
        }
    }
    
    @Published var showToast = false
    
    // MARK: - Show Toast
    
    func toastView() -> AnyView {
        switch toast {
        case .none:
            return EmptyView().eraseToAnyView()
            
        case .taskCreated:
            return createToastView(
                title: NSLocalizedString("toast.task_created", comment: "Toast created text"),
                color: .t_green
            ).eraseToAnyView()
            
        case .taskCompleted:
            return createToastView(
                title: NSLocalizedString("toast.task_completed", comment: "Toast completed text"),
                color: .t_green
            ).eraseToAnyView()
            
        case .taskDeleted:
            return createToastView(
                title: NSLocalizedString("toast.task_deleted", comment: "Toast deleted text"),
                color: .t_green
            ).eraseToAnyView()
            
        case .taskUpdated:
            return createToastView(
                title: NSLocalizedString("toast.task_updated", comment: "Toast updated text"),
                color: .t_green
            ).eraseToAnyView()
            
        }
    }
    
    func createToastView(title: String, color: Color) -> some View {
        VStack {
            Spacer()
            Text(title)
                .font(.title20)
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
        .padding(Layout.Padding.cozy)
        .frame(width: UIScreen.screenWidth, height: 100)
        .background(color)
    }
}
