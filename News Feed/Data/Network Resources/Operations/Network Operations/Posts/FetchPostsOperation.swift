//
//  FetchPostsOperation.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 08/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import CoreData

class FetchPostsOperation: ConcurrentOperation<PostsRemote> {
    
    private let session: URLSession
    private let requestFactory: PostsURLRequestFactory
    private var sessionTask: URLSessionTask?
    private let persistentContainer: NSPersistentContainer

    
    init(session: URLSession = URLSession.shared,
         requestFactory: PostsURLRequestFactory = PostsURLRequestFactory(), 
        _ persistentContainer: NSPersistentContainer) {
        self.session = session
        self.requestFactory = requestFactory
        self.persistentContainer = persistentContainer
    }
    
    override func main() {

        let request = requestFactory.retrivePosts()
        
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
                let posts = try decoder.decode(PostsRemote.self, from: data)
                
                // clear previous data before saving
                self.clearStoredData()
                
                // save locally
                posts.forEach { post in
                    _ = PostLocal(userId: post.userId, id: post.id, body: post.body, title: post.title, needSave: true, context: managedContext)
                }
                
                try managedContext.save()
                self.complete(result: .success(posts))
            } catch {
                self.complete(result: .failure(BaseError.parsingError))
            }
        }
        
        sessionTask?.resume()
    }
    
    func clearStoredData() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try self.persistentContainer.viewContext.execute(deleteRequest)
            try self.persistentContainer.viewContext.save()
        } catch {
            print ("Post table might already be cleared")
        }
    }
    
    // MARK: Cancel task
    override func cancel() {
        sessionTask?.cancel()
        super.cancel()
    }
    
}
