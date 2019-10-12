//
//  MockCommentsRepository.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 12/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift
@testable import News_Feed


class MockCommentsRepository: CommentsRepository {
    
    var getCommentsReturn: Observable<Result<Comments, Error>>!
    func getComments() -> Observable<Result<Comments, Error>> {
        return getCommentsReturn
    }
}
