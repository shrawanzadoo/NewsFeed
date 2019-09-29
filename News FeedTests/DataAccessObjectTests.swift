//
//  DataAccessObjectTests.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 22/09/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import XCTest
import CoreData
@testable import News_Feed

class DataAccessObjectTests: XCTestCase {
    
    var dao: DataAccessObject!
    var mockPersistanceProvider = MockPersistanceProvider()
    let mockNetworkManager = MockNetworkManager()
    let queueManager = QueueManager.shared
    
    override func setUp() {
        super.setUp()
        
        dao = DataAccessObjectImpl(queueManager: queueManager, networkManager: mockNetworkManager, persistanceProvider: mockPersistanceProvider)
    }
    
    func testUserFetch() {
        // load users into storage
        loadUsersIntoStorage()
        
        // verify users in storage
        XCTAssertEqual(10, dao.fetchUsersFromStorage().count)
    }
    
    func testPostsFetch() {
        // load posts into storage
        loadPostsIntoStorage()
        
        // verify posts in storage
        XCTAssertEqual(100, dao.fetchPostsFromStorage().count)
    }
    
    func testCommentsFetch() {
        // load comments into storage
        loadCommentsIntoStorage()
        
        // verify comments in storage
        XCTAssertEqual(500, dao.fetchCommentsFromStorage().count)
    }
    
    //MARK: Helpers
    
    func loadUsersIntoStorage() {
        let users = MockDataHelper.getUsers(saveData: true)
        print("🚨 TEST users : \(users.count)")
    }
    
    func loadPostsIntoStorage() {
        let posts: Posts = MockDataHelper.getPosts(saveData: true)
        print("🚨 TEST posts : \(posts.count)")
    }
    
    func loadCommentsIntoStorage() {
        let comments: Comments = MockDataHelper.getComments(saveData: true)
        print("🚨 TEST comments : \(comments.count)")
    }
}

