//
//  DataAccessObjectImpl.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 06/08/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

class DataAccessObjectImpl: DataAccessObject {
    
    private let queueManager: QueueManager
    let networkManager: NetworkManager
    private let persistanceProvider: PersistanceProvider

    init(queueManager: QueueManager = QueueManager.shared,
         networkManager: NetworkManager = NetworkManagerImpl(),
         persistanceProvider: PersistanceProvider = PersistanceProviderImpl()) {
        self.queueManager = queueManager
        self.networkManager = networkManager
        self.persistanceProvider = persistanceProvider
        
//        clearDataFromStorage()
    }
    
    func fetchUsers() -> Observable<Result<UsersRemote, Error>> {
        return networkManager.fetchUsers().asObservable()
    }
    
    func fetchPosts() -> Observable<Result<PostsRemote, Error>> {
        return networkManager.fetchPosts().asObservable()
    }
    
    func fetchComments() -> Observable<Result<CommentsRemote, Error>> {
        return networkManager.fetchComments().asObservable()
    }
    
    func fetchUsersFromStorage() -> UsersLocal {
        var users: UsersLocal = []
        let managedContext = self.persistanceProvider.getPersistanceContainer().newBackgroundContext()
        let fetchRequest = NSFetchRequest<UserLocal>(entityName: "User")
        do {
            users = try managedContext.fetch(fetchRequest)
        } catch let error {
            print("Failed to fetch Comments error \(error.localizedDescription)")
        }
        return users
    }
    
    func fetchPostsFromStorage() -> PostsLocal {
        var posts: PostsLocal = []
        let managedContext = self.persistanceProvider.getPersistanceContainer().newBackgroundContext()
        let fetchRequest = NSFetchRequest<PostLocal>(entityName: "Post")
        do {
            posts = try managedContext.fetch(fetchRequest)
        } catch let error {
            print("Failed to fetch Comments error \(error.localizedDescription)")
        }
        return posts
    }
    
    func fetchCommentsFromStorage() -> CommentsLocal {
        var comments: CommentsLocal = []
        let managedContext = self.persistanceProvider.getPersistanceContainer().newBackgroundContext()
        let fetchRequest = NSFetchRequest<CommentLocal>(entityName: "Comment")
        do {
            comments = try managedContext.fetch(fetchRequest)
        } catch let error {
            print("Failed to fetch Comments error \(error.localizedDescription)")
        }
        return comments
    }
    
    // MARK: Clear storage
    private func clearDataFromStorage() {
        clearGeo()
        clearCompany()
        clearAddress()
        clearUsers()
        
        clearPostsFromStorage()
        clearCommentsFromStorage()
    }
    
    private func clearPostsFromStorage() {
        
        let managedContext = self.persistanceProvider.getPersistanceContainer().newBackgroundContext()
        let fetchRequest = NSFetchRequest<PostLocal>(entityName: "Post")
        managedContext.performAndWait {
            do {
                let posts = try managedContext.fetch(fetchRequest)
                posts.forEach { post in
                    managedContext.delete(post)
                }
                try managedContext.save()
            } catch let error {
                print("Clear Posts error \(error.localizedDescription)")
            }
        }
    }
    
    private func clearUsers() {
        let managedContext = self.persistanceProvider.getPersistanceContainer().newBackgroundContext()
        let fetchRequest = NSFetchRequest<UserLocal>(entityName: "User")
        managedContext.performAndWait {
            do {
                let users = try managedContext.fetch(fetchRequest)
                users.forEach { user in
                    managedContext.delete(user)
                }
                try managedContext.save()
            } catch let error {
                print("Clear User error \(error.localizedDescription)")
            }
        }
    }
    
    private func clearAddress() {
        let managedContext = self.persistanceProvider.getPersistanceContainer().newBackgroundContext()
        let fetchRequest = NSFetchRequest<AddressLocal>(entityName: "Address")
        managedContext.performAndWait {
            do {
                let addresses = try managedContext.fetch(fetchRequest)
                addresses.forEach { address in
                    managedContext.delete(address)
                }
                try managedContext.save()
            } catch let error {
                print("Clear Address error \(error.localizedDescription)")
            }
        }
    }
    
    private func clearGeo() {
        let managedContext = self.persistanceProvider.getPersistanceContainer().newBackgroundContext()
        let fetchRequest = NSFetchRequest<GeoLocal>(entityName: "Geo")
        managedContext.performAndWait {
            do {
                let locations = try managedContext.fetch(fetchRequest)
                locations.forEach { location in
                    managedContext.delete(location)
                }
                try managedContext.save()
            } catch let error {
                print("Clear Geo error \(error.localizedDescription)")
            }
        }
    }
    
    private func clearCompany() {
        let managedContext = self.persistanceProvider.getPersistanceContainer().newBackgroundContext()
        let fetchRequest = NSFetchRequest<CompanyLocal>(entityName: "Company")
        managedContext.performAndWait {
            do {
                let companies = try managedContext.fetch(fetchRequest)
                companies.forEach { company in
                    managedContext.delete(company)
                }
                try managedContext.save()
            } catch let error {
                print("Clear company error \(error.localizedDescription)")
            }
        }
    }
    
    private func clearCommentsFromStorage() {
        let managedContext = self.persistanceProvider.getPersistanceContainer().newBackgroundContext()
        let fetchRequest = NSFetchRequest<CommentLocal>(entityName: "Comment")
        managedContext.performAndWait {
            do {
                let comments = try managedContext.fetch(fetchRequest)
                comments.forEach { comment in
                    managedContext.delete(comment)
                }
                try managedContext.save()
            } catch let error {
                print("Clear Comments error \(error.localizedDescription)")
            }
        }
    }
}
