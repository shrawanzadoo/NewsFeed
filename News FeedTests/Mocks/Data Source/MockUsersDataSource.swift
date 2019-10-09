//
//  MockUsersDataSource.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

@testable import News_Feed

class MockUsersDataSource: UsersDataSource {
    
    var getUsersCount = 0
    var getUsersReturns = MockDataHelper.getUsers()
    func getUsers() -> Single<Result<Users, Error>> {
        getUsersCount += 1
        return Single.just(.success(getUsersReturns))
    }
}
