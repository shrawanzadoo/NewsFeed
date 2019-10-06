//
//  GetPosts.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 06/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

class GetPosts: UseCase {

    typealias Q = String
    typealias T = Result<Posts, Error>
    
    let postsDataManager: PostsDataManager
    
    init(postsDataManager: PostsDataManager = PostsDataManagerImpl()) {
        self.postsDataManager = postsDataManager
    }
    
    // imagine these posts will be for a user
    // so we will need to pass in the user user id/auth/session
    // which is not used now
    func execute(requestValues: Q) -> Observable<T> {
        return postsDataManager
            .fetchPosts().asObservable()
    }
}
