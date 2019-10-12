//
//  PostCard.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 06/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation

struct PostCard: Equatable {
    
    static func == (lhs: PostCard, rhs: PostCard) -> Bool {
        return lhs.postId == rhs.postId && lhs.userId == rhs.userId
    }
    
    let userId: Int
    let postId: Int
    
    let name: String
    let userName: String
    let email: String
    
    let postTitle: String
    let postBody: String
    
    let comments: [DisplayComment]
}
