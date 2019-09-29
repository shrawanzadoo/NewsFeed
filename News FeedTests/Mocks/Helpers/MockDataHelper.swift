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
    
    public static  func getUsers(saveData: Bool = false) -> Users {
        return readFromFile("users", saveData: saveData)!
    }
    
    public static  func getPosts(saveData: Bool = false) -> Posts {
        return readFromFile("posts", saveData: saveData)!
    }

    public static  func getComments(saveData: Bool = false) -> Comments {
        return readFromFile("comments", saveData: saveData)!
    }
    
    private static  func readFromFile<T: Codable>(_ fileName: String, saveData: Bool = false) -> T? {
        
        let bundle = Bundle(for: type(of: MockDataHelper()))
        print("🚨 TEST Reading from file : \(fileName).json")
        
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
            if saveData {
                try managedObjectContext.save()
            }
            return serialisedData
        } catch {
            return nil
        }
    }
}
