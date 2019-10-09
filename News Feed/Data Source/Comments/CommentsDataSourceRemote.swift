//
//  CommentsDataSourceRemote.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

class CommentsDataSourceRemote: CommentsDataSource {
    
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
