//
//  PostsDataSourceRemote.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

class PostsDataSourceRemote: PostsDataSource {
    
    let postsDataManager: PostsDataManager
    
    init(postsDataManager: PostsDataManager = PostsDataManagerImpl()) {
        self.postsDataManager = postsDataManager
    }
    
    func getPosts() -> Single<Result<Posts, Error>> {
        return self.postsDataManager.fetchPosts().map { result in
            switch(result) {
            case .success(let postsRemote):
                var posts: Posts = []
                postsRemote.forEach { postRemote in
                    posts.append(Post(userId: postRemote.userId, id: postRemote.id, body: postRemote.body, title: postRemote.title))
                }
                return .success(posts)
            case .failure(let error):
                return .failure(error)
            }
        }
    }
}

