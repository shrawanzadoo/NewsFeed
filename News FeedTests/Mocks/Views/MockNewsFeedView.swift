//
//  MockNewsFeedView.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 12/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import XCTest

@testable import News_Feed

class MockNewsFeedView: NewsFeedViewContract {
    
    var updateNewsFeedCount = 0
    var updateNewsFeedParam: [[PostCard]?] = []
    func updateNewsFeed(postCards: [PostCard]?) {
        updateNewsFeedCount += 1
        updateNewsFeedParam.append(postCards)
    }
    
    var showErrorCount = 0
    func showError() {
        showErrorCount += 1
    }
}
