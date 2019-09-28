//
//  PostsURLRequestFactory.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 16/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation

class CommentsURLRequestFactory: URLRequestFactory {
    
    func retriveComments() -> URLRequest {
        var request = jsonRequest(endPoint: "comments")
        request.httpMethod = HTTPMethod.get.rawValue
        return request
    }
    
}
