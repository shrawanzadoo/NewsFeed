//
//  PostsDataSourceTests.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import XCTest

@testable import News_Feed

class RemotePostsDataSourceTests: XCTestCase {
    
    let schedulerProvider = MockSchedulerProvider()
    
    func testPostDataSourceSuccess() {
        
        let uds = PostsDataSourceRemote(postsDataManager: MockPostsDataManager())
        _ = uds.getPosts()
            .subscribeOn(schedulerProvider.io())
            .observeOn(schedulerProvider.ui())
            .subscribe(onSuccess: { result in
                switch(result) {
                case .success(let posts):
                    XCTAssertEqual(100, posts.count)
                case .failure(_):
                    XCTFail()
                }
            })
    }
}
