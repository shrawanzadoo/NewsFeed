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
    
    static var mockPersistentContainer = MockPersistanceContainer().mockPersistentContainer
    
    public static  func getUsers() -> Users {
        return readFromFile("users")!
    }
    
    public static  func getPosts() -> Posts {
        return readFromFile("posts")!
    }

    public static  func getComments() -> Comments {
        return readFromFile("comments")!
    }
    
    private static  func readFromFile<T: Codable>(_ fileName: String) -> T? {
        
        let bundle = Bundle(for: type(of: MockDataHelper()))
        
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
