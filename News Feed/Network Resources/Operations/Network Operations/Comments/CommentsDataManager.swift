//
//  PostaDataManager.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 20/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

protocol CommentsDataManager {
    func fetchComments() -> Single<Result<CommentsRemote, Error>>
}

class CommentsDataManagerImpl: CommentsDataManager {
    
    private let queueManager: QueueManager
    private let persistanceProvider: PersistanceProvider
    
    init(queueManager: QueueManager = QueueManager.shared,
         persistanceProvider: PersistanceProvider = PersistanceProviderImpl()) {
        self.queueManager = queueManager
        self.persistanceProvider = persistanceProvider
    }
    
    func fetchComments() -> Single<Result<CommentsRemote, Error>> {
        return Single.create { emitter in
            let operation = FetchCommentsOperation(self.persistanceProvider.getPersistanceContainer())
            operation.completionHandler = { result in
                emitter(.success(result))
            }
            self.queueManager.enquqe(operation)
            return Disposables.create { }
        }
        
    }
}
