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
    
    @ViewBuilder
    func toastView() -> some View {
        switch toast {
        case .none:
            EmptyView()
            
        case .taskCreated:
            createToastView(
                title: NSLocalizedString("toast.task_created", comment: "Toast created text"),
                color: .t_green
            )
            
        case .taskCompleted:
            createToastView(
                title: NSLocalizedString("toast.task_completed", comment: "Toast completed text"),
                color: .t_green
            )
            
        case .taskDeleted:
            createToastView(
                title: NSLocalizedString("toast.task_deleted", comment: "Toast deleted text"),
                color: .t_green
            )
            
        case .taskUpdated:
            createToastView(
                title: NSLocalizedString("toast.task_updated", comment: "Toast updated text"),
                color: .t_green
            )
        }
    }
    
    func createToastView(title: String, color: Color) -> some View {
        VStack {
            Spacer()
            Text(title)
                .font(.bold_20)
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
        .padding(Layout.Padding.cozy)
        .frame(width: UIScreen.screenWidth, height: 100)
        .background(color)
    }
}
