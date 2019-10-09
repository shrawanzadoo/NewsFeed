//
//  PostsRepositoryTests.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import XCTest

@testable import News_Feed

class PostsRepositoryTests: XCTestCase {
    
    let schedulerProvider = MockSchedulerProvider()
    
    func post_repo_test_success() {
        
        let repo: PostsRepository = PostsRepositoryImpl(dataSources: [MockPostsDataSource()])
        _ = repo.getPosts()
            .subscribeOn(schedulerProvider.io())
            .observeOn(schedulerProvider.ui())
            .subscribe(onNext: { result in
                switch(result) {
                case .success(let posts):
                    XCTAssertEqual(10, posts.count)
                case .failure(_):
                    XCTFail()
                }
            })
        
    }
}
