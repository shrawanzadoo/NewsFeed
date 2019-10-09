//
//  MockNetworkManager.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 22/09/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift
@testable import News_Feed


class MockNetworkManager: NetworkManager {
    
    var fetchUsersCount = 0
    lazy var fetchUsersReturns = MockDataHelper.getUsers()
    func fetchUsers() -> Single<Result<UsersRemote, Error>> {
        fetchUsersCount += 1
        return Single.just(.success(fetchUsersReturns))
    }
    
    var fetchPostsCount = 0
    lazy var fetchPostsReturns = MockDataHelper.getPosts()
    func fetchPosts() -> Single<Result<PostsRemote, Error>> {
        fetchPostsCount += 1
        return Single.just(.success(fetchPostsReturns))
    }
    
    var fetchCommentsCount = 0
    lazy var fetchCommentsReturns = MockDataHelper.getComments()
    func fetchComments() -> Single<Result<CommentsRemote, Error>> {
        fetchCommentsCount += 1
        return Single.just(.success(fetchCommentsReturns))
    }
}
