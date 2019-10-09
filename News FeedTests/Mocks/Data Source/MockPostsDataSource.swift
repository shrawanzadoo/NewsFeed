//
//  MockPostsDataSource.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

@testable import News_Feed

class MockPostsDataSource: PostsDataSource {
    
    var getPostsCount = 0
    var getPostsReturns = MockDataHelper.getPosts()
    func getPosts() -> Single<Result<Posts, Error>> {
        getPostsCount += 1
        return Single.just(.success(getPostsReturns))
    }
}
