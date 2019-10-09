//
//  Posts.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 09/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation

typealias PostsRemote = [PostRemote]

struct PostRemote: Codable {
    
    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
    
    var userId: Int
    var id: Int
    var body: String
    var title: String
}
