//
//  MockDataAccessObject.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 22/09/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
import RxTest
@testable import News_Feed

class MockDataAccessObject: DataAccessObject {
    
    var fetchUsersCount = 0
    var fetchUsersReturns = MockDataHelper.getUsers()
    func fetchUsers() -> Observable<Result<Users, Error>> {
        fetchUsersCount += 1
        return Observable.from(optional: .success(fetchUsersReturns))
    }
    
    
    var fetchPostsCount = 0
    var fetchPostsReturns = MockDataHelper.getPosts()
    func fetchPosts() -> Observable<Result<Posts, Error>> {
        fetchPostsCount += 1
        return Observable.from(optional: .success(fetchPostsReturns))
    }
    
    
    var fetchCommentsCount = 0
    var fetchCommentsReturns = MockDataHelper.getComments()
    func fetchComments() -> Observable<Result<Comments, Error>> {
        fetchCommentsCount += 1
        return Observable.from(optional: .success(fetchCommentsReturns))
    }
    
    var fetchUsersFromStorageCount = 0
    var fetchUsersFromStorageReturns = MockDataHelper.getUsers()
    func fetchUsersFromStorage() -> Users {
        fetchUsersFromStorageCount += 1
        return fetchUsersFromStorageReturns
    }
    
    
    var fetchPostsFromStorageCount = 0
    var fetchPostsFromStorageReturns = MockDataHelper.getPosts()
    func fetchPostsFromStorage() -> Posts {
        fetchPostsFromStorageCount += 1
        return fetchPostsFromStorageReturns
    }
    
    
    var fetchCommentsFromStorageCount = 0
    var fetchCommentsFromStorageReturns = MockDataHelper.getComments()
    func fetchCommentsFromStorage() -> Comments {
        fetchCommentsFromStorageCount += 1
        return fetchCommentsFromStorageReturns
    }
}
