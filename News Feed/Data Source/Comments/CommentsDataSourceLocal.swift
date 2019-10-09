//
//  CommentsDataSourceLocal.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

class CommentsDataSourceLocal: CommentsDataSource {
    
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
