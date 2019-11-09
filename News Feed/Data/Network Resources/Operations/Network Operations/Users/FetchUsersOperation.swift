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
                let users = try decoder.decode(UsersRemote.self, from: data)
                
                // clear previous data before saving
                self.clearStoredData()
                
                // save locally
                users.forEach { user in
                    _ = UserLocal(id: user.id, name: user.name, username: user.username, email: user.email, address: AddressLocal(street: user.address.street, suite: user.address.suite, city: user.address.city, zipcode: user.address.zipcode, geo: GeoLocal(lat: user.address.geo.lat, lng: user.address.geo.lng, needSave: true, context: managedContext), needSave: true, context: managedContext), phone: user.phone, website: user.website, company: CompanyLocal(name: user.company.name, catchPhrase: user.company.catchPhrase, bs: user.company.bs, needSave: true, context: managedContext), needSave: true, context: managedContext)
                }
                
                try managedContext.save()
                self.complete(result: .success(users))
            } catch {
                self.complete(result: .failure(BaseError.parsingError))
            }
        }
        
        sessionTask?.resume()
    }
    
    func clearStoredData() {
        clearDataFor("User")
        clearDataFor("Address")
        clearDataFor("Geo")
        clearDataFor("Company")
    }
    
    private func clearDataFor(_ entity: String) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try self.persistentContainer.viewContext.execute(deleteRequest)
            try self.persistentContainer.viewContext.save()
        } catch {
            print ("\(entity) table might already be cleared")
        }
    }
    
    
    // MARK: Cancel task
    override func cancel() {
        sessionTask?.cancel()
        super.cancel()
    }
    
}

