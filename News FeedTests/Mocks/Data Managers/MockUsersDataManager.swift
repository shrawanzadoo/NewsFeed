//
//  MockUsersDataManager.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

@testable import News_Feed

class MockUsersDataManager: UsersDataManager {
    
    var fetchUsersCount = 0
    var fetchUsersReturn = MockDataHelper.getUsersRemote()
    func fetchUsers() -> Single<Result<UsersRemote, Error>> {
        fetchUsersCount += 1
        return Single.just(.success(fetchUsersReturn))
    }
}
