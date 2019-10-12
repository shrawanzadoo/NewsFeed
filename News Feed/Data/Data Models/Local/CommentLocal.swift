//
//  Comment.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 20/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import CoreData

typealias CommentsLocal = [CommentLocal]

@objc(CommentLocal)
class CommentLocal: NSManagedObject {
    
    @NSManaged var postId: Int
    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var email: String
    @NSManaged var body: String
    
    convenience init(postId: Int, id: Int, name: String, email: String,
                     body: String,
                     needSave: Bool, context: NSManagedObjectContext) {

        let entity = NSEntityDescription.entity(forEntityName: "Comment", in: context)

        if(!needSave) {
            self.init(entity: entity!, insertInto: nil)
        } else {
            self.init(entity: entity!, insertInto: context)
        }
        
        self.postId = postId
        self.id = id
        self.name = name
        self.email = email
        self.body = body
    }
}
