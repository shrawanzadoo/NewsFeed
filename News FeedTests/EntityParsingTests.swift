//
//  News_FeedTests.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 07/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import XCTest
import CoreData
@testable import News_Feed

class EntityParsingTests: XCTestCase {
    
    lazy var mockPersistentContainer = MockPersistanceContainer().mockPersistentContainer

    func testUserParsing() {
        guard let users: Users = verifyParsing("users") else {
            XCTFail()
            return
        }
        XCTAssertEqual(10, users.count)
    }
    
    func testCommentsParsing() {
        guard let comments: Comments = verifyParsing("comments") else {
            XCTFail()
            return
        }
        XCTAssertEqual(500, comments.count)
    }
    
    func testPostsParsing() {
        guard let posts: Posts = verifyParsing("posts") else {
            XCTFail()
            return
        }
        XCTAssertEqual(100, posts.count)
    }
    
    func verifyParsing<T: Codable>(_ fileName: String) -> T? {
        
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing file: \(fileName).json")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let managedObjectContext = mockPersistentContainer.viewContext
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext!] = managedObjectContext
            let serialisedData = try decoder.decode(T.self, from: data)
            return serialisedData
        } catch {
            return nil
        }
    }
    
    
}