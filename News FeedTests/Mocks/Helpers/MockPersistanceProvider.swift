//
//  MockPersistanceProvider.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 22/09/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import CoreData

@testable import News_Feed

class MockPersistanceProvider: PersistanceProvider {
    func getPersistanceContainer() -> NSPersistentContainer {
        return MockPersistanceContainer().mockPersistentContainer
    }
}
