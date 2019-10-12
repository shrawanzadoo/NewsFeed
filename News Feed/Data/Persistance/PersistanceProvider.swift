//
//  PersistanceProvider.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 06/08/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import CoreData

protocol PersistanceProvider {
    func getPersistanceContainer() -> NSPersistentContainer
}

class PersistanceProviderImpl: PersistanceProvider {
    
    func getPersistanceContainer() -> NSPersistentContainer {
        return CoreDataManager.shared.persistentContainer
    }
}
