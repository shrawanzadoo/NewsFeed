//
//  MockUsersRepository.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 12/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift
@testable import News_Feed


class MockUsersRepository: UsersRepository {
    
    var getUsersReturn: Observable<Result<Users, Error>>!
    func getUsers() -> Observable<Result<Users, Error>> {
        return getUsersReturn
    }
}
