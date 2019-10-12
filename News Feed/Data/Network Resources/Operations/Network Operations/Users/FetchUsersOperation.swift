//
//  FetchUsersOperation.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 20/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import CoreData

class FetchUsersOperation: ConcurrentOperation<UsersRemote> {
    
    private let session: URLSession
    private let requestFactory: UsersURLRequestFactory
    private var sessionTask: URLSessionTask?
    private let persistentContainer: NSPersistentContainer
    
    init(session: URLSession = URLSession.shared,
         requestFactory: UsersURLRequestFactory = UsersURLRequestFactory(),
         _ persistentContainer: NSPersistentContainer) {
        self.session = session
        self.requestFactory = requestFactory
        self.persistentContainer = persistentContainer
    }
    
    override func main() {
        
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
            fatalError("Failed to retrieve managed object context")
        }
        
        let request = requestFactory.retriveUsers()
        
        
        sessionTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    self.complete(result: .failure(error))
                } else {
                    self.complete(result: .failure(BaseError.noData))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let managedContext = self.persistentContainer.viewContext
                decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedContext
                let users = try decoder.decode(UsersRemote.self, from: data)
                
                try managedContext.save()
                self.complete(result: .success(users))
            } catch {
                self.complete(result: .failure(BaseError.parsingError))
            }
        }
        
        sessionTask?.resume()
    }
    
    
    // MARK: Cancel task
    override func cancel() {
        sessionTask?.cancel()
        super.cancel()
    }
    
}

