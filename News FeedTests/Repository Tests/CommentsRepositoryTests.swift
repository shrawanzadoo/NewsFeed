//
//  CommentsRepositoryTests.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import XCTest
import RxSwift

@testable import News_Feed

class CommentsRepositoryTests: XCTestCase {
    
    var disposeBag: DisposeBag!
    
    override func setUp() {
        disposeBag = DisposeBag()
    }
    
    func testCommentRepoSuccess() {
        
        let dataSource = MockCommentsDataSource()
        dataSource.getCommentsReturns = Single.just(.success(MockDataHelper.getComments()))
        
        let repo: CommentsRepository = CommentsRepositoryImpl(dataSources: [dataSource])
        _ = repo.getComments()
            .subscribe(onNext: { result in
                switch(result) {
                case .success(let comments):
                    XCTAssertEqual(500, comments.count)
                case .failure(_):
                    XCTFail()
                }
            }).disposed(by: disposeBag)
        
        // verify data source method called
        XCTAssertEqual(1, dataSource.getCommentsCount)
    }
    
    func testCommentRepoFail() {
        
        let dataSource = MockCommentsDataSource()
        
        dataSource.getCommentsReturns = Single.just(.failure(BaseError.noData))
        let repo: CommentsRepository = CommentsRepositoryImpl(dataSources: [dataSource])
        
        _ = repo.getComments()
            .subscribe(onNext: { result in
                switch(result) {
                case .success(_):
                    XCTFail()
                case .failure(let error):
                    XCTAssertEqual(BaseError.noData, error as! BaseError)
                }
            }).disposed(by: disposeBag)
        
        // verify data source method called
        XCTAssertEqual(1, dataSource.getCommentsCount)
    }
}
