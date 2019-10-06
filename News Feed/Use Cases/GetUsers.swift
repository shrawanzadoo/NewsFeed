//
//  GetUsers.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 06/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

class GetUsers: UseCase {

    typealias Q = String
    typealias T = Result<Users, Error>
    
    let usersDataManager: UsersDataManager
    
    init(usersDataManager: UsersDataManager = UsersDataManagerImpl()) {
        self.usersDataManager = usersDataManager
    }
    
    // imagine these posts will be for a user
    // so we will need to pass in the user id/auth/session
    // which is not used now
    func execute(requestValues: Q) -> Observable<T> {
        return usersDataManager
            .fetchUsers().asObservable()
    }
}
