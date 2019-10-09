//
//  GetComments.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 06/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

class GetComments: UseCase {

    typealias Q = String
    typealias T = Result<Comments, Error>
    
    let commentsRepository: CommentsRepository
    
    init(commentsRepository: CommentsRepository = CommentsRepositoryImpl()) {
        self.commentsRepository = commentsRepository
    }
    
    // imagine these comments will be for a user
    // so we will need to pass in the user user id/auth/session
    // which is not used now
    func execute(requestValues: Q) -> Observable<T> {
        return commentsRepository.getComments()
    }
}
