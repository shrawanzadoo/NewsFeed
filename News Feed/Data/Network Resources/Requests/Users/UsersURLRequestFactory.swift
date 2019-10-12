//
//  UsersURLRequestFactory.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 20/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation

class UsersURLRequestFactory: URLRequestFactory {
    
    func retriveUsers() -> URLRequest {
        var request = jsonRequest(endPoint: "users")
        request.httpMethod = HTTPMethod.get.rawValue
        return request
    }
    
}
