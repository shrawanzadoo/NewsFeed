//
//  Posts.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 09/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import CoreData

typealias PostsLocal = [PostLocal]

@objc(PostLocal)
class PostLocal: NSManagedObject {
    @NSManaged var userId: Int
    @NSManaged var id: Int
    @NSManaged var body: String
    @NSManaged var title: String
    
    convenience init(userId: Int, id: Int, body: String, title: String,
        needSave: Bool, context: NSManagedObjectContext) {

        let entity = NSEntityDescription.entity(forEntityName: "Post", in: context)

        if(!needSave) {
            self.init(entity: entity!, insertInto: nil)
        } else {
            self.init(entity: entity!, insertInto: context)
        }

        // Init class variables
        self.id = id
        self.userId = userId
        self.body = body
        self.title = title
    }
}
