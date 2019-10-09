//
//  PostsRepository.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 06/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

protocol PostsRepository {
    func getPosts() -> Observable<Result<Posts, Error>>
}

class PostsRepositoryImpl: PostsRepository {
    
    let dataSources: [PostsDataSource]
    
    init(dataSources: [PostsDataSource] = [PostsDataSourceLocal(), PostsDataSourceRemote()]) {
        self.dataSources = dataSources
    }
    
    func getPosts() -> Observable<Result<Posts, Error>> {
        return Observable.concat(dataSources.compactMap { $0.getPosts().asObservable() })
    }
}
