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
    func fetchUsers() -> Observable<Result<Users, Error>>
    func fetchPosts() -> Observable<Result<Posts, Error>>
    func fetchComments() -> Observable<Result<Comments, Error>>
    func fetchUsersFromStorage() -> UsersLocal
    func fetchPostsFromStorage() -> PostsLocal
    func fetchCommentsFromStorage() -> CommentsLocal
}
