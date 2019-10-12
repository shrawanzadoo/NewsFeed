//
//  UsersRepository.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

protocol UsersRepository {
    func getUsers() -> Observable<Result<Users, Error>>
}

class UsersRepositoryImpl: UsersRepository {
    
    let dataSources: [UsersDataSource]
    
    init(dataSources: [UsersDataSource] = [UsersDataSourceLocal(), UsersDataSourceRemote()]) {
        self.dataSources = dataSources
    }
    
    func getUsers() -> Observable<Result<Users, Error>> {
        return Observable.concat(dataSources.compactMap { $0.getUsers().asObservable() })
    }
}
