//
//  NewFeedPresenterTests.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 12/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import XCTest
import RxSwift

@testable import News_Feed

class NewsFeedPresenterTests: XCTestCase {
    
    let mockScheduler = MockSchedulerProvider()
    
    var view: MockNewsFeedView!
    var mockPostsRepository: MockPostsRepository!
    var mockUsersRepository: MockUsersRepository!
    var mockCommentsRepository: MockCommentsRepository!
    var mockGetPostsUseCase: GetPosts!
    var mockGetUsersUseCase: GetUsers!
    var mockGetCommentsUseCase: GetComments!
    var presenter: NewsFeedPresenter!
    
    override func setUp() {
        view = MockNewsFeedView()
        
        mockPostsRepository = MockPostsRepository()
        mockUsersRepository = MockUsersRepository()
        mockCommentsRepository = MockCommentsRepository()
        
        mockPostsRepository.getPostsReturn = Observable.just(.success(MockDataHelper.getPosts()))
        mockUsersRepository.getUsersReturn = Observable.just(.success(MockDataHelper.getUsers()))
        mockCommentsRepository.getCommentsReturn = Observable.just(.success(MockDataHelper.getComments()))
        
        mockGetPostsUseCase = GetPosts(postsRepository: mockPostsRepository)
        mockGetUsersUseCase = GetUsers(usersRepository: mockUsersRepository)
        mockGetCommentsUseCase = GetComments(commentsRepository: mockCommentsRepository)
        
        presenter = NewsFeedPresenter(scheduler: mockScheduler,
                                          getPostsUseCase: mockGetPostsUseCase,
                                          getUsersUseCase: mockGetUsersUseCase,
                                          getCommentsUseCase: mockGetCommentsUseCase)
    }
    
    func testUpdateWithAllData() {

        mockPostsRepository.getPostsReturn = Observable.just(.success(MockDataHelper.getPosts()))
        mockUsersRepository.getUsersReturn = Observable.just(.success(MockDataHelper.getUsers()))
        mockCommentsRepository.getCommentsReturn = Observable.just(.success(MockDataHelper.getComments()))
        
        presenter.takeView(view)
        
        presenter.getNewsFeed()
        XCTAssertEqual(100, view.updateNewsFeedParam[0].count)
    }
    
    func testUpdateWithoutComments() {

        mockPostsRepository.getPostsReturn = Observable.just(.success(MockDataHelper.getPosts()))
        mockUsersRepository.getUsersReturn = Observable.just(.success(MockDataHelper.getUsers()))
        mockCommentsRepository.getCommentsReturn = Observable.just(.failure(BaseError.noData))
        
        presenter.takeView(view)
        
        presenter.getNewsFeed()
        
        // number of post cards should be the same, since comments are not required for a post
        XCTAssertEqual(100, view.updateNewsFeedParam[0].count)
    }
    
    func testUpdateWithoutUsers() {
        
        mockPostsRepository.getPostsReturn = Observable.just(.success(MockDataHelper.getPosts()))
        mockUsersRepository.getUsersReturn = Observable.just(.failure(BaseError.noData))
        mockCommentsRepository.getCommentsReturn = Observable.just(.failure(BaseError.noData))
        
        presenter.takeView(view)
        
        presenter.getNewsFeed()
        
        // there should be no posts since we can't assosiate a post with a user
        XCTAssertEqual(0, view.updateNewsFeedParam[0].count)
    }
    
    func testUpdateWithoutPosts() {
        
        mockPostsRepository.getPostsReturn = Observable.just(.failure(BaseError.noData))
        mockUsersRepository.getUsersReturn = Observable.just(.failure(BaseError.noData))
        mockCommentsRepository.getCommentsReturn = Observable.just(.failure(BaseError.noData))
        
        presenter.takeView(view)
        
        presenter.getNewsFeed()
        
        // there should be no posts
        XCTAssertEqual(0, view.updateNewsFeedParam[0].count)
    }
    
}
