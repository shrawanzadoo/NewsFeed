//
//  MockPostsDataManager.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

@testable import News_Feed

class MockPostsDataManager: PostsDataManager {
    
    var fetchPostsCount = 0
    var fetchPostsReturn = MockDataHelper.getPostsRemote()
    func fetchPosts() -> Single<Result<PostsRemote, Error>> {
        fetchPostsCount += 1
        return Single.just(.success(fetchPostsReturn))
    }
}
