//
//  User.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 20/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import CoreData

typealias UsersLocal = [UserLocal]

@objc(UserLocal)
class UserLocal: NSManagedObject {
    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var username: String
    @NSManaged var email: String
    @NSManaged var address: AddressLocal
    @NSManaged var phone: String
    @NSManaged var website: String
    @NSManaged var company: CompanyLocal
    
    convenience init(id: Int, name: String, username: String, email: String,
                     address: AddressLocal, phone: String, website: String,
                     company: CompanyLocal,
                     needSave: Bool, context: NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)

        if(!needSave) {
            self.init(entity: entity!, insertInto: nil)
        } else {
            self.init(entity: entity!, insertInto: context)
        }
        
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }
}

@objc(AddressLocal)
class AddressLocal: NSManagedObject {
    
    @NSManaged var street: String
    @NSManaged var suite: String
    @NSManaged var city: String
    @NSManaged var zipcode: String
    @NSManaged var geo: GeoLocal
    
    convenience init(street: String, suite: String, city: String, zipcode: String,
                 geo: GeoLocal,
                 needSave: Bool, context: NSManagedObjectContext) {
    
        let entity = NSEntityDescription.entity(forEntityName: "Address", in: context)

        if(!needSave) {
            self.init(entity: entity!, insertInto: nil)
        } else {
            self.init(entity: entity!, insertInto: context)
        }
        
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }
}

@objc(GeoLocal)
class GeoLocal: NSManagedObject {
    
    @NSManaged var lat: String
    @NSManaged var lng: String
    
    convenience init(lat: String, lng: String,
                 needSave: Bool, context: NSManagedObjectContext) {
    
        let entity = NSEntityDescription.entity(forEntityName: "Geo", in: context)

        if(!needSave) {
            self.init(entity: entity!, insertInto: nil)
        } else {
            self.init(entity: entity!, insertInto: context)
        }
        
        self.lat = lat
        self.lng = lng
    }
}

@objc(CompanyLocal)
class CompanyLocal: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var catchPhrase: String
    @NSManaged var bs: String
    
    convenience init(name: String, catchPhrase: String, bs: String,
                 needSave: Bool, context: NSManagedObjectContext) {
    
        let entity = NSEntityDescription.entity(forEntityName: "Company", in: context)

        if(!needSave) {
            self.init(entity: entity!, insertInto: nil)
        } else {
            self.init(entity: entity!, insertInto: context)
        }
        
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
}
