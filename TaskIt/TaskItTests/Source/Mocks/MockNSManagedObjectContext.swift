//
//  MockNSManagedObjectContext.swift
//  TaskItTests
//
//  Created by Kyle Dold on 17/02/2021.
//

import CoreData
import Foundation

class MockNSManagedObjectContext: NSManagedObjectContext {

    init() {
        super.init(concurrencyType: .mainQueueConcurrencyType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
