//
//  PostaDataManager.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 20/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

protocol PostsDataManager {
    func fetchPosts() -> Single<Result<PostsRemote, Error>>
}

class PostsDataManagerImpl: PostsDataManager {
    
    private let queueManager: QueueManager
    private let persistanceProvider: PersistanceProvider
    
    init(queueManager: QueueManager = QueueManager.shared,
         persistanceProvider: PersistanceProvider = PersistanceProviderImpl()) {
        self.queueManager = queueManager
        self.persistanceProvider = persistanceProvider
    }
    
    func fetchPosts() -> Single<Result<PostsRemote, Error>> {
        return Single.create { emitter in
            let operation = FetchPostsOperation(self.persistanceProvider.getPersistanceContainer())
            operation.completionHandler = { result in
                emitter(.success(result))
            }
            self.queueManager.enquqe(operation)
            return Disposables.create { }
        }
        
    }
}
