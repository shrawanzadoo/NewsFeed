//
//  DataAccessObject.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 06/08/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

protocol DataAccessObject {
    func fetchUsers() -> Observable<Result<UsersRemote, Error>>
    func fetchPosts() -> Observable<Result<PostsRemote, Error>>
    func fetchComments() -> Observable<Result<CommentsRemote, Error>>
    func fetchUsersFromStorage() -> UsersLocal
    func fetchPostsFromStorage() -> PostsLocal
    func fetchCommentsFromStorage() -> CommentsLocal
}
