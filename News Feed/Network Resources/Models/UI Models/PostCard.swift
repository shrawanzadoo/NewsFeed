//
//  PostCard.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 06/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation

struct PostCard {
    let userId: String
    let postId: String
    
    let name: String
    let userName: String
    let email: String
    
    let postTitle: String
    let postBody: String
    
    let comments: [DisplayComment]
}
