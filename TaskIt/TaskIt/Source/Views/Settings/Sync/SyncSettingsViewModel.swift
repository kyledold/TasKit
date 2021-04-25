//
//  SyncSettingsViewModel.swift
//  TaskIt
//
//  Created by Kyle Dold on 22/04/2021.
//

import Combine
import Foundation

class SyncSettingsViewModel: SyncSettingsViewModelProtocol {
    
    // MARK: - Properties
    
    var titleText = NSLocalizedString("settings.sync_settings.title", comment: "title")
    
    var iCloudSyncText = NSLocalizedString("settings.sync_settings.icloud.title", comment: "icloud sync title")
    var iCloudSyncDescription = NSLocalizedString("settings.sync_settings.icloud.description", comment: "icloud sync description")
    
    @Published var isICloudSyncEnabled: Bool
    
    private var subscribers: Set<AnyCancellable> = []
    
    // MARK: - Initialisation
    
    init() {
        isICloudSyncEnabled = AppSettings.boolValue(.iCloudSync)
        
        addObservers()
    }
    
    // MARK: - Observers
    
    private func addObservers() {
        
        $isICloudSyncEnabled.dropFirst().sink { newValue in
            AppSettings[.iCloudSync] = newValue
        }.store(in: &subscribers)
    }
}
