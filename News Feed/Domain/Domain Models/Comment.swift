//
//  Comment.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 08/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation

typealias Comments = [Comment]

struct Comment {
    
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
