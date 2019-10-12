//
//  UsersDataSourceLocal.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

class UsersDataSourceLocal: UsersDataSource {
    
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
