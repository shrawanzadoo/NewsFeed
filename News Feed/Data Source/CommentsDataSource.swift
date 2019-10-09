//
//  CommentsDataSource.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 08/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

protocol CommentsDataSource {
    func getComments() -> Single<Result<Comments, Error>>
}

class CommentsDataSourceLocal: CommentsDataSource {
    
    let commentsDataManager: CommentsDataManager
    
    init(commentsDataManager: CommentsDataManager = CommentsDataManagerImpl()) {
        self.commentsDataManager = commentsDataManager
    }
    
    func getComments() -> Single<Result<Comments, Error>> {
        return self.commentsDataManager.fetchComments().map { result in
            switch(result) {
            case .success(let commentsRemote):
                var comments: Comments = []
                commentsRemote.forEach { commentRemote in
                    comments.append(Comment(postId: commentRemote.postId, id: commentRemote.id, name: commentRemote.name, email: commentRemote.email, body: commentRemote.body))
                }
                return .success(comments)
            case .failure(let error):
                return .failure(error)
            }
        }
    }
}

class CommentsDataSourceRemote: CommentsDataSource {
    
    private let persistanceProvider: PersistanceProvider
    
    init(persistanceProvider: PersistanceProvider = PersistanceProviderImpl()) {
        self.persistanceProvider = persistanceProvider
    }
    
    func getComments() -> Single<Result<Comments, Error>> {
        var commentsLocal: CommentsLocal = []
        let managedContext = self.persistanceProvider.getPersistanceContainer().newBackgroundContext()
        let fetchRequest = NSFetchRequest<CommentLocal>(entityName: "Comment")
        do {
            commentsLocal = try managedContext.fetch(fetchRequest)
        } catch let error {
            print("Failed to fetch Comment error \(error.localizedDescription)")
            return Single.just(.failure(error))
        }
        var comments: Comments = []
        commentsLocal.forEach { commentLocal in
            comments.append(Comment(postId: commentLocal.postId, id: commentLocal.id, name: commentLocal.name, email: commentLocal.email, body: commentLocal.body))
        }
        return Single.just(.success(comments))
    }
}
