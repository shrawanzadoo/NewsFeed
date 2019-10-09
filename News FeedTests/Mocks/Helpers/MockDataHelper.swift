//
//  MockDataHelper.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 22/09/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import CoreData
import XCTest

@testable import News_Feed

class MockDataHelper {
    
    static var mockPersistentContainer = MockPersistanceProvider().getPersistanceContainer()
    
    public static func getUsers() -> UsersRemote {
        return readFromFile("users")!
    }
    
    public static func getPosts() -> PostsRemote {
        return readFromFile("posts")!
    }

    public static func getComments() -> CommentsRemote {
        return readFromFile("comments")!
    }
    
    public static func getUsersLocal(saveData: Bool = false) -> UsersLocal {
        var usersLocal: UsersLocal = []
        getUsers().forEach { user in
            usersLocal.append(UserLocal(id: user.id, name: user.name, username: user.username, email: user.email, address: AddressLocal(street: user.address.street, suite: user.address.suite, city: user.address.city, zipcode: user.address.zipcode, geo: GeoLocal(lat: user.address.geo.lat, lng: user.address.geo.lng, needSave: saveData, context: mockPersistentContainer.viewContext), needSave: saveData, context: mockPersistentContainer.viewContext), phone: user.phone, website: user.website, company: CompanyLocal(name: user.company.name, catchPhrase: user.company.catchPhrase, bs: user.company.bs, needSave: saveData, context: mockPersistentContainer.viewContext), needSave: saveData, context: mockPersistentContainer.viewContext))
        }
        if saveData { do { try mockPersistentContainer.viewContext.save() } catch {} }
        return usersLocal
    }
    
    public static func getPostsLocal(saveData: Bool = false) -> PostsLocal {
        var postsLocal: PostsLocal = []
        getPosts().forEach { post in
            postsLocal.append(PostLocal(userId: post.userId, id: post.id, body: post.body, title: post.title, needSave: saveData, context: mockPersistentContainer.viewContext))
        }
        if saveData { do { try mockPersistentContainer.viewContext.save() } catch {} }
        return postsLocal
    }

    public static func getCommentsLocal(saveData: Bool = false) -> CommentsLocal {
        var commentsLocal: CommentsLocal = []
        getComments().forEach { comment in
            commentsLocal.append(CommentLocal(postId: comment.postId, id: comment.id, name: comment.name, email: comment.email, body: comment.body, needSave: saveData, context: mockPersistentContainer.viewContext))
        }
        if saveData { do { try mockPersistentContainer.viewContext.save() } catch {} }
        return commentsLocal
    }
    
    private static func readFromFile<T: Codable>(_ fileName: String) -> T? {
        
        let bundle = Bundle(for: type(of: MockDataHelper()))
        print("🚨 TEST Reading from file : \(fileName).json")
        
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing file: \(fileName).json")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let serialisedData = try JSONDecoder().decode(T.self, from: data)
            return serialisedData
        } catch {
            return nil
        }
    }
}
