//
//  UsersDataSource.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 08/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

protocol UsersDataSource {
    func getUsers() -> Single<Result<Users, Error>>
}

class UsersDataSourceLocal: UsersDataSource {
    
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

class UsersDataSourceRemote: UsersDataSource {
    
    private let persistanceProvider: PersistanceProvider
    
    init(persistanceProvider: PersistanceProvider = PersistanceProviderImpl()) {
        self.persistanceProvider = persistanceProvider
    }
    
    func getUsers() -> Single<Result<Users, Error>> {
        var usersLocal: UsersLocal = []
        let managedContext = self.persistanceProvider.getPersistanceContainer().newBackgroundContext()
        let fetchRequest = NSFetchRequest<UserLocal>(entityName: "User")
        do {
            usersLocal = try managedContext.fetch(fetchRequest)
        } catch let error {
            print("Failed to fetch Users error \(error.localizedDescription)")
            return Single.just(.failure(error))
        }
        var users: Users = []
        usersLocal.forEach { userLocal in
            users.append(User(id: userLocal.id, name: userLocal.name, username: userLocal.username, email: userLocal.email, postcode: userLocal.address.zipcode, phone: userLocal.phone, website: userLocal.website, companyName: userLocal.company.name))
        }
        return Single.just(.success(users))
    }
}
