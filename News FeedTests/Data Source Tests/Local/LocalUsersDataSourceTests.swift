//
//  LocalUsersDataSourceTests.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import XCTest

@testable import News_Feed

class LocalUsersDataSourceTests: XCTestCase {
    
    let schedulerProvider = MockSchedulerProvider()
    
    func testUserDataSourceSuccess() {
        
        loadUsersIntoStorage()
        
        let uds = UsersDataSourceLocal(persistanceProvider: MockPersistanceProvider())
        _ = uds.getUsers()
            .subscribeOn(schedulerProvider.io())
            .observeOn(schedulerProvider.ui())
            .subscribe(onSuccess: { result in
                switch(result) {
                case .success(let users):
                    XCTAssertEqual(10, users.count)
                case .failure(_):
                    XCTFail()
                }
            })
    }
    
    //MARK: Helper
    func loadUsersIntoStorage() {
        let users = MockDataHelper.getUsersLocal(saveData: true)
        print("🚨 TEST users : \(users.count)")
    }
}

