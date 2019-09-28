//
//  Comment.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 20/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import CoreData

typealias Comments = [Comment]

@objc(Comment)
class Comment: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case postId
        case id
        case name
        case email
        case body
    }
    
    @NSManaged var postId: Int
    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var email: String
    @NSManaged var body: String
    
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Comment", in: managedObjectContext) else {
                fatalError("Failed to decode Comment")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.postId = try container.decodeIfPresent(Int.self, forKey: .postId)!
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)!
        self.name = try container.decodeIfPresent(String.self, forKey: .name)!
        self.email = try container.decodeIfPresent(String.self, forKey: .email)!
        self.body = try container.decodeIfPresent(String.self, forKey: .body)!
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(postId, forKey: .postId)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(body, forKey: .body)
    }
}
