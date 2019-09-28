//
//  NetworkManager.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 06/08/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkManager {
    func fetchUsers() -> Single<Result<Users, Error>>
    func fetchPosts() -> Single<Result<Posts, Error>>
    func fetchComments() -> Single<Result<Comments, Error>>
}
