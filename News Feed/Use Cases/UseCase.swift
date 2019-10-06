//
//  UseCase.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 06/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

protocol UseCase {
    associatedtype Q
    associatedtype T
    func execute(requestValues: Q) -> Observable<T>
}
