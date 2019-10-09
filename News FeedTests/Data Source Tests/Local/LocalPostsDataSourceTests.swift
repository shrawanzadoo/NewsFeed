//
//  LocalPostsDataSourceTests.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import XCTest

@testable import News_Feed

class LocalPostsDataSourceTests: XCTestCase {
    
    let schedulerProvider = MockSchedulerProvider()
    
    func testPostDataSourceSuccess() {
        
        loadPostsIntoStorage()
        
        let uds = PostsDataSourceLocal(persistanceProvider: MockPersistanceProvider())
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
    
    //MARK: Helper
    func loadPostsIntoStorage() {
        let posts = MockDataHelper.getPostsLocal(saveData: true)
        print("🚨 TEST posts : \(posts.count)")
    }
}

