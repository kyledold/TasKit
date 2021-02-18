//
//  NewTaskInputAccessoryView.swift
//  TaskIt
//
//  Created by Kyle Dold on 18/02/2021.
//

import SwiftUI
import UIKit
import Combine

struct NewTaskInputAccessoryView : UIViewRepresentable {

    @Binding var text: String

    let textField = UITextField(frame: CGRect(x:0, y:0, width: 100, height: 32)) // just any

    func makeUIView(context: UIViewRepresentableContext<NewTaskInputAccessoryView>) -> UITextField {
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<NewTaskInputAccessoryView>) {
        self.textField.text = text
    }

    func makeCoordinator() -> NewTaskInputAccessoryView.Coordinator {
        let coordinator = Coordinator(self)

        // configure a toolbar with a Done button
        let toolbar = UIToolbar()
        toolbar.setItems([
            // just moves the Done item to the right
            UIBarButtonItem(
                barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace
                , target: nil
                , action: nil
            )
            , UIBarButtonItem(
                title: "Done"
                , style: UIBarButtonItem.Style.done
                , target: coordinator
                , action: #selector(coordinator.onSet)
            )
            ]
            , animated: true
        )
        toolbar.barStyle = UIBarStyle.default
        toolbar.sizeToFit()

        textField.inputAccessoryView = toolbar
        return coordinator
    }

    typealias UIViewType = UITextField

    class Coordinator: NSObject {
        let owner: NewTaskInputAccessoryView
        private var subscriber: AnyCancellable

        init(_ owner: NewTaskInputAccessoryView) {
            self.owner = owner
            subscriber = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: owner.textField)
                .sink(receiveValue: { _ in
                    owner.$text.wrappedValue = owner.textField.text ?? ""
                })
        }

        @objc fileprivate func onSet() {
            owner.textField.resignFirstResponder()
        }

    }
}
