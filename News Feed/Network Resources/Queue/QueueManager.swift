//
//  BaseQueue.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 20/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation

class QueueManager {
    
    lazy var queue: OperationQueue = {
        let quque = OperationQueue()
        
        return quque
    }()
    
    static let shared = QueueManager()
    
    func enquqe(_ operation: Operation) {
        queue.addOperation(operation)
    }
}
