//
//  MockCommentsDataManager.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

@testable import News_Feed

class MockCommentsDataManager: CommentsDataManager {
    
    var fetchCommentsCount = 0
    var fetchCommentsReturn = MockDataHelper.getCommentsRemote()
    func fetchComments() -> Single<Result<CommentsRemote, Error>> {
        fetchCommentsCount += 1
        return Single.just(.success(fetchCommentsReturn))
    }
}
