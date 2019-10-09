//
//  NetworkManagerImpl.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 06/08/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

class NetworkManagerImpl: NetworkManager {
    
    let usersDataManager: UsersDataManager
    let postsDataManager: PostsDataManager
    let commentsDataManager: CommentsDataManager
    
    init(usersDataManager: UsersDataManager = UsersDataManagerImpl(),
         postsDataManager: PostsDataManager = PostsDataManagerImpl(),
         commentsDataManager: CommentsDataManager = CommentsDataManagerImpl()) {
        self.usersDataManager = usersDataManager
        self.postsDataManager = postsDataManager
        self.commentsDataManager = commentsDataManager
    }
    
    func fetchUsers() -> Single<Result<UsersRemote, Error>> {
        return usersDataManager
            .fetchUsers()
    }
    
    func fetchPosts() -> Single<Result<PostsRemote, Error>> {
        return postsDataManager
            .fetchPosts()
    }
    
    func fetchComments() -> Single<Result<CommentsRemote, Error>> {
        return commentsDataManager
            .fetchComments()
    }
}
