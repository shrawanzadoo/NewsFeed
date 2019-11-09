//
//  NewFeedPresenterContract.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 12/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation

protocol NewsFeedPresenterContract {
    func takeView(_ view: NewsFeedViewContract)
    func getNewsFeed()
}

protocol NewsFeedViewContract {
    func updateNewsFeed(postCards: [PostCard]?)
    func showError()
}
