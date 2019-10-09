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
    
    let usersRepository: UsersRepository
    
    init(usersRepository: UsersRepository = UsersRepositoryImpl()) {
        self.usersRepository = usersRepository
    }
    
    // imagine these users will be for a user
    // so we will need to pass in the user user id/auth/session
    // which is not used now
    func execute(requestValues: Q) -> Observable<T> {
        return usersRepository.getUsers()
    }
}
