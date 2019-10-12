//
//  CommentsRepository.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

protocol CommentsRepository {
    func getComments() -> Observable<Result<Comments, Error>>
}

class CommentsRepositoryImpl: CommentsRepository {
    
    let dataSources: [CommentsDataSource]
    
    init(dataSources: [CommentsDataSource] = [CommentsDataSourceLocal(), CommentsDataSourceRemote()]) {
        self.dataSources = dataSources
    }
    
    func getComments() -> Observable<Result<Comments, Error>> {
        return Observable.concat(dataSources.compactMap { $0.getComments().asObservable() })
    }
}
