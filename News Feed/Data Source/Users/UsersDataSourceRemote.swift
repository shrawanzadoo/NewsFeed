//
//  UsersDataSourceRemote.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

class UsersDataSourceRemote: UsersDataSource {
    
    let usersDataManager: UsersDataManager
    
    init(usersDataManager: UsersDataManager = UsersDataManagerImpl()) {
        self.usersDataManager = usersDataManager
    }
    
    func getUsers() -> Single<Result<Users, Error>> {
        return self.usersDataManager.fetchUsers().map { result in
            switch(result) {
            case .success(let usersRemote):
                var users: Users = []
                usersRemote.forEach { userRemote in
                    users.append(User(id: userRemote.id, name: userRemote.name, username: userRemote.username, email: userRemote.email, postcode: userRemote.address.zipcode, phone: userRemote.phone, website: userRemote.website, companyName: userRemote.company.name))
                }
                return .success(users)
            case .failure(let error):
                return .failure(error)
            }
        }
    }
}
