//
//  Comment.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 20/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation

typealias CommentsRemote = [CommentRemote]

struct CommentRemote: Codable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
