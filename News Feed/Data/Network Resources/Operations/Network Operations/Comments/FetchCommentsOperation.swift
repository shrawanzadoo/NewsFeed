//
//  FetchUsersOperation.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 20/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import CoreData

class FetchCommentsOperation: ConcurrentOperation<CommentsRemote> {
    
    private let session: URLSession
    private let requestFactory: CommentsURLRequestFactory
    private var sessionTask: URLSessionTask?
    private let persistentContainer: NSPersistentContainer
    
    init(session: URLSession = URLSession.shared,
         requestFactory: CommentsURLRequestFactory = CommentsURLRequestFactory(), 
        _ persistentContainer: NSPersistentContainer) {
        self.session = session
        self.requestFactory = requestFactory
        self.persistentContainer = persistentContainer
    }
    
    override func main() {

        let request = requestFactory.retriveComments()
        
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
                let comments = try decoder.decode(CommentsRemote.self, from: data)
                
                // clear previous data before saving
                self.clearStoredData()
                
                // save locally
                comments.forEach { comment in
                    _ = CommentLocal(postId: comment.postId, id: comment.id, name: comment.name, email: comment.email, body: comment.body, needSave: true, context: managedContext)
                }
                
                try managedContext.save()
                self.complete(result: .success(comments))
            } catch {
                self.complete(result: .failure(BaseError.parsingError))
            }
        }
        
        sessionTask?.resume()
    }
    
    func clearStoredData() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Comment")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try self.persistentContainer.viewContext.execute(deleteRequest)
            try self.persistentContainer.viewContext.save()
        } catch {
            print ("Comments table might already be cleared")
        }
    }
    
    // MARK: Cancel task
    override func cancel() {
        sessionTask?.cancel()
        super.cancel()
    }
    
}

