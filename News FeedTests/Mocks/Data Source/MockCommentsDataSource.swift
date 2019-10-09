//
//  MockCommentsDataSource.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

@testable import News_Feed

class MockCommentsDataSource: CommentsDataSource {
    
    var getCommentsCount = 0
    var getCommentsReturns = MockDataHelper.getComments()
    func getComments() -> Single<Result<Comments, Error>> {
        getCommentsCount += 1
        return Single.just(.success(getCommentsReturns))
    }
}
