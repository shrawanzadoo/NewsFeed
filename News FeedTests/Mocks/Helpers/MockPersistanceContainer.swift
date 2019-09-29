//
//  MockPersistanceContainer.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 22/09/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import XCTest
import Foundation
import CoreData

class MockPersistanceContainer {
    
    public static let container = MockPersistanceContainer()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        return managedObjectModel
    }()
    
    lazy var mockPersistentContainer: NSPersistentContainer = {
        objc_sync_enter(self)
        let container = NSPersistentContainer(name: "NewsFeed", managedObjectModel: managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition(description.type == NSInMemoryStoreType)
            if let error = error {
                XCTFail("Error creating mock: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        objc_sync_exit(self)
        return container
    }()
}
