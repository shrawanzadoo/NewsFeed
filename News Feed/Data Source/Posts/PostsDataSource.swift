//
//  PostsDataSource.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 08/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

protocol PostsDataSource {
    func getPosts() -> Single<Result<Posts, Error>>
}
