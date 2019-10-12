//
//  UsersRepositoryTests.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import XCTest
import RxSwift

@testable import News_Feed

class UsersRepositoryTests: XCTestCase {
    
    var disposeBag: DisposeBag!
    
    override func setUp() {
        disposeBag = DisposeBag()
    }
    
    func testUserRepoSuccess() {
        
        let dataSource = MockUsersDataSource()
        
        dataSource.getUsersReturns = Single.just(.success(MockDataHelper.getUsers()))

        let repo: UsersRepository = UsersRepositoryImpl(dataSources: [dataSource])
        
        _ = repo.getUsers()
            .subscribe(onNext: { result in
                switch(result) {
                case .success(let users):
                    XCTAssertEqual(10, users.count)
                case .failure(_):
                    XCTFail()
                }
            })
            .disposed(by: disposeBag)
        
        // verify data source method called
        XCTAssertEqual(1, dataSource.getUsersCount)
    }
    
    func testUserRepoFail() {
        
        let dataSource = MockUsersDataSource()
        
        dataSource.getUsersReturns = Single.just(.failure(BaseError.parsingError))

        let repo: UsersRepository = UsersRepositoryImpl(dataSources: [dataSource])
        
        _ = repo.getUsers()
            .subscribe(onNext: { result in
                switch(result) {
                case .success(_):
                    XCTFail()
                case .failure(let error):
                    XCTAssertEqual(BaseError.parsingError, error as! BaseError)
                }
            }).disposed(by: disposeBag)
        
        // verify data source method called
        XCTAssertEqual(1, dataSource.getUsersCount)
    }
}
