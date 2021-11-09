//
//  NotificationExtension.swift
//  TasKit
//
//  Created by Kyle Dold on 24/02/2021.
//

import Foundation

extension Notification.Name {
    static let taskCompleted = Notification.Name("TaskCompleted")
    static let taskCreated = Notification.Name("TaskCreated")
    static let taskDeleted = Notification.Name("TaskDeleted")
    static let taskUpdated = Notification.Name("TaskUpdated")
}
