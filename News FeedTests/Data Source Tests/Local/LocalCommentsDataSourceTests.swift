//
//  LocalCommentsDataSourceTests.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import XCTest

@testable import News_Feed

class LocalCommentsDataSourceTests: XCTestCase {
    
    let schedulerProvider = MockSchedulerProvider()
    
    func testCommentDataSourceSuccess() {
        
        loadCommentsIntoStorage()
        
        let uds = CommentsDataSourceLocal(persistanceProvider: MockPersistanceProvider())
        _ = uds.getComments()
            .subscribeOn(schedulerProvider.io())
            .observeOn(schedulerProvider.ui())
            .subscribe(onSuccess: { result in
                switch(result) {
                case .success(let comments):
                    XCTAssertEqual(500, comments.count)
                case .failure(_):
                    XCTFail()
                }
            })
    }
    
    //MARK: Helper
    func loadCommentsIntoStorage() {
        let comments = MockDataHelper.getCommentsLocal(saveData: true)
        print("🚨 TEST comments : \(comments.count)")
    }
}

