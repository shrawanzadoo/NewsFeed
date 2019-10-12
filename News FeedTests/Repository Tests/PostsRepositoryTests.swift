//
//  PostsRepositoryTests.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import XCTest
import RxSwift

@testable import News_Feed

class PostsRepositoryTests: XCTestCase {
    
    var disposeBag: DisposeBag!
    
    override func setUp() {
        disposeBag = DisposeBag()
    }
    
    func testPostRepoSuccess() {

        let dataSource = MockPostsDataSource()
        dataSource.getPostsReturns = Single.just(.success(MockDataHelper.getPosts()))
        
        let repo: PostsRepository = PostsRepositoryImpl(dataSources: [dataSource])
        _ = repo.getPosts()
            .subscribe(onNext: { result in
                switch(result) {
                case .success(let posts):
                    XCTAssertEqual(100, posts.count)
                case .failure(_):
                    XCTFail()
                }
            }).disposed(by: disposeBag)
        
        // verify data source method called
        XCTAssertEqual(1, dataSource.getPostsCount)
    }
    
    func testPostRepoFailure() {

        let dataSource = MockPostsDataSource()
        dataSource.getPostsReturns = Single.just(.failure(BaseError.noData))
        
        let repo: PostsRepository = PostsRepositoryImpl(dataSources: [dataSource])
        _ = repo.getPosts()
            .subscribe(onNext: { result in
                switch(result) {
                case .success(_):
                    XCTFail()
                case .failure(let error):
                    XCTAssertEqual(BaseError.noData, error as! BaseError)
                }
            }).disposed(by: disposeBag)
        
        // verify data source method called
        XCTAssertEqual(1, dataSource.getPostsCount)
    }
}
