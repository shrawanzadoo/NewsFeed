//
//  UsersRepositoryTests.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import XCTest

@testable import News_Feed

class UsersRepositoryTests: XCTestCase {
    
    let schedulerProvider = MockSchedulerProvider()
    
    func user_repo_test_success() {
        
        let repo: UsersRepository = UsersRepositoryImpl(dataSources: [MockUsersDataSource()])
        _ = repo.getUsers()
            .subscribeOn(schedulerProvider.io())
            .observeOn(schedulerProvider.ui())
            .subscribe(onNext: { result in
                switch(result) {
                case .success(let users):
                    XCTAssertEqual(10, users.count)
                case .failure(_):
                    XCTFail()
                }
            })
        
    }
}
