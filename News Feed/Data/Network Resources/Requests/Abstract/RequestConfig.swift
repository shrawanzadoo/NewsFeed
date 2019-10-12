//
//  RequestConfig.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 16/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class RequestConfig {
    
    let hostURL: String
    
    init() {
        hostURL = "https://jsonplaceholder.typicode.com"
    }
}
