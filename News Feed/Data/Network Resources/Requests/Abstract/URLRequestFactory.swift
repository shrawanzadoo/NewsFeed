//
//  URLRequestFactory.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 16/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation

enum BaseError: Error, Equatable {
    case noData
    case parsingError
}

class URLRequestFactory {
    
    let config: RequestConfig

    init(config: RequestConfig = RequestConfig()) {
        self.config = config
    }
    
    func baseRequest(endPoint: String) -> URLRequest {
        let urlString = config.hostURL + "/\(endPoint)"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }
    
    func jsonRequest(endPoint: String) -> URLRequest {
        var request = baseRequest(endPoint: endPoint)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
