//
//  Post.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 08/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation

typealias Posts = [Post]

struct Post {
    var userId: Int
    var id: Int
    var body: String
    var title: String
}
