//
//  Posts.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 09/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import CoreData

typealias Posts = [Post]

@objc(Post)
class Post: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
    
    @NSManaged var userId: Int
    @NSManaged var id: Int
    @NSManaged var body: String
    @NSManaged var title: String
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Post", in: managedObjectContext) else {
                fatalError("Failed to decode Post")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decodeIfPresent(Int.self, forKey: .userId)!
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)!
        self.body = try container.decodeIfPresent(String.self, forKey: .body)!
        self.title = try container.decodeIfPresent(String.self, forKey: .title)!
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userId, forKey: .userId)
        try container.encode(id, forKey: .id)
        try container.encode(body, forKey: .body)
        try container.encode(title, forKey: .title)
    }
}
