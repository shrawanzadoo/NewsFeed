//
//  MockPostsRepository.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 12/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift
@testable import News_Feed


class MockPostsRepository: PostsRepository {
    
    var getPostsReturn: Observable<Result<Posts, Error>>!
    func getPosts() -> Observable<Result<Posts, Error>> {
        return getPostsReturn
    }
}
