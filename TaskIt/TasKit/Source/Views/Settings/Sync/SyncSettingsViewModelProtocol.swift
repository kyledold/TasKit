//
//  SyncSettingsViewModelProtocol.swift
//  TasKit
//
//  Created by Kyle Dold on 22/04/2021.
//

import Foundation

protocol SyncSettingsViewModelProtocol: ObservableObject {
    
    var titleText: String { get }
    
    var iCloudSyncText: String { get }
    var iCloudSyncDescription: String { get }
    var isICloudSyncEnabled: Bool { get set }
}
