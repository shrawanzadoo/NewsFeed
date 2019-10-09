//
//  PostsDataSource.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 08/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

protocol PostsDataSource {
    func getPosts() -> Single<Result<Posts, Error>>
}

class PostsDataSourceLocal: PostsDataSource {
    
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

class PostsDataSourceRemote: PostsDataSource {
    
    private let persistanceProvider: PersistanceProvider
    
    init(persistanceProvider: PersistanceProvider = PersistanceProviderImpl()) {
        self.persistanceProvider = persistanceProvider
    }
    
    func getPosts() -> Single<Result<Posts, Error>> {
        var postsLocal: PostsLocal = []
        let managedContext = self.persistanceProvider.getPersistanceContainer().newBackgroundContext()
        let fetchRequest = NSFetchRequest<PostLocal>(entityName: "Post")
        do {
            postsLocal = try managedContext.fetch(fetchRequest)
        } catch let error {
            print("Failed to fetch Posts error \(error.localizedDescription)")
            return Single.just(.failure(error))
        }
        var posts: Posts = []
        postsLocal.forEach { postLocal in
            posts.append(Post(userId: postLocal.userId, id: postLocal.id, body: postLocal.body, title: postLocal.title))
        }
        return Single.just(.success(posts))
    }
}
