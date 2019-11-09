//
//  CoreDataManager.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 11/08/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager("NewsFeed")
    
    private let modelName: String
    
    lazy var persistentContainer: NSPersistentContainer = {
        objc_sync_enter(self)
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        objc_sync_exit(self)
        return container
    }()
    
    private init(_ modelName: String) {
        self.modelName = modelName
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
