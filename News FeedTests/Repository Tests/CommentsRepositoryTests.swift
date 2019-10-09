//
//  CommentsRepositoryTests.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import XCTest

@testable import News_Feed

class CommentsRepositoryTests: XCTestCase {
    
    let schedulerProvider = MockSchedulerProvider()
    
    func comment_repo_test_success() {
        
        let repo: CommentsRepository = CommentsRepositoryImpl(dataSources: [MockCommentsDataSource()])
        _ = repo.getComments()
            .subscribeOn(schedulerProvider.io())
            .observeOn(schedulerProvider.ui())
            .subscribe(onNext: { result in
                switch(result) {
                case .success(let comments):
                    XCTAssertEqual(10, comments.count)
                case .failure(_):
                    XCTFail()
                }
            })
        
    }
}
