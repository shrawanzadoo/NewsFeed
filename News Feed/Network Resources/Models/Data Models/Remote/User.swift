//
//  User.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 20/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation

typealias Users = [User]

struct User: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
    
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
}

struct Address: Codable {
    
    enum CodingKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipcode
        case geo
    }
    
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: Geo
}

struct Geo: Codable {
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
    
    var lat: String
    var lng: String
}

struct Company: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case bs
    }
    
    var name: String
    var catchPhrase: String
    var bs: String
}
