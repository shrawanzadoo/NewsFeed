//
//  User.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 20/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import CoreData

typealias Users = [User]

@objc(User)
class User: NSManagedObject, Codable {
    
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
    
    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var username: String
    @NSManaged var email: String
    @NSManaged var address: Address
    @NSManaged var phone: String
    @NSManaged var website: String
    @NSManaged var company: Company
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else {
                fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)!
        self.name = try container.decodeIfPresent(String.self, forKey: .name)!
        self.username = try container.decodeIfPresent(String.self, forKey: .username)!
        self.email = try container.decodeIfPresent(String.self, forKey: .email)!
        self.address = try container.decodeIfPresent(Address.self, forKey: .address)!
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)!
        self.website = try container.decodeIfPresent(String.self, forKey: .website)!
        self.company = try container.decodeIfPresent(Company.self, forKey: .company)!
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(username, forKey: .username)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encode(phone, forKey: .phone)
        try container.encode(website, forKey: .website)
        try container.encode(company, forKey: .company)
    }
}

@objc(Address)
class Address: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipcode
        case geo
    }
    
    @NSManaged var street: String
    @NSManaged var suite: String
    @NSManaged var city: String
    @NSManaged var zipcode: String
    @NSManaged var geo: Geo
    
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Address", in: managedObjectContext) else {
                fatalError("Failed to decode Address")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try container.decodeIfPresent(String.self, forKey: .street)!
        self.suite = try container.decodeIfPresent(String.self, forKey: .suite)!
        self.city = try container.decodeIfPresent(String.self, forKey: .city)!
        self.zipcode = try container.decodeIfPresent(String.self, forKey: .zipcode)!
        self.geo = try container.decodeIfPresent(Geo.self, forKey: .geo)!
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(street, forKey: .street)
        try container.encode(suite, forKey: .suite)
        try container.encode(city, forKey: .city)
        try container.encode(zipcode, forKey: .zipcode)
        try container.encode(geo, forKey: .geo)
    }
}

@objc(Geo)
class Geo: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
    
    @NSManaged var lat: String
    @NSManaged var lng: String
    
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Geo", in: managedObjectContext) else {
                fatalError("Failed to decode Geo")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lat = try container.decodeIfPresent(String.self, forKey: .lat)!
        self.lng = try container.decodeIfPresent(String.self, forKey: .lng)!
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lat, forKey: .lat)
        try container.encode(lng, forKey: .lng)
    }
}

@objc(Company)
class Company: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case bs
    }
    
    @NSManaged var name: String
    @NSManaged var catchPhrase: String
    @NSManaged var bs: String
    
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Company", in: managedObjectContext) else {
                fatalError("Failed to decode Company")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)!
        self.catchPhrase = try container.decodeIfPresent(String.self, forKey: .catchPhrase)!
        self.bs = try container.decodeIfPresent(String.self, forKey: .bs)!
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(catchPhrase, forKey: .catchPhrase)
        try container.encode(bs, forKey: .bs)
    }
}
