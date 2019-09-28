//
//  DataAccessObjectTests.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 22/09/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import XCTest
@testable import News_Feed

class DataAccessObjectTests: XCTestCase {
    
    var dao: DataAccessObject!
    let mockPersistanceProvider = MockPersistanceProvider()
    let mockNetworkManager = MockNetworkManager()
    let queueManager = QueueManager.shared
    
    override func setUp() {
        //load data for Users, Comments and Posts into mock storage for retrevial
        loadUsersIntoStorage()
        loadCommentsIntoStorage()
        loadPostsIntoStorage()
        do {
            try mockPersistanceProvider.getPersistanceContainer().viewContext.save()
        } catch let error {
            print("\(error)")
        }
        
        dao = DataAccessObjectImpl(queueManager: queueManager, networkManager: mockNetworkManager, persistanceProvider: mockPersistanceProvider)
    }
    
    func testUserFetch() {
        XCTAssertEqual(10, dao.fetchUsersFromStorage().count)
    }
    
    func testPostsFetch() {
        XCTAssertEqual(100, dao.fetchPostsFromStorage().count)
    }
    
    func testCommentsFetch() {
        XCTAssertEqual(500, dao.fetchCommentsFromStorage().count)
    }
    
    //MARK: Helpers
    
    func loadUsersIntoStorage() {
        _ = MockDataHelper.getUsers()
    }
    
    func loadPostsIntoStorage() {
        _ = MockDataHelper.getPosts()
    }
    
    func loadCommentsIntoStorage() {
        _ = MockDataHelper.getComments()
    }
}

