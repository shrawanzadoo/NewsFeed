//
//  ConcurrentOperation.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 08/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation

class ConcurrentOperation<T>: Operation {
    
    typealias NetworkResult = Result<T, Error>
    typealias OperationCompletionHandler = (_ result: NetworkResult) -> Void
    
    var completionHandler: OperationCompletionHandler?
    
    private enum State: String {
        case ready = "isReady"
        case executing = "isExecuting"
        case finished = "isFinished"
    }
    
    private var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.rawValue)
            willChangeValue(forKey: state.rawValue)
        }
        
        didSet {
            willChangeValue(forKey: oldValue.rawValue)
            willChangeValue(forKey: state.rawValue)
        }
    }
    
    public func isReady() -> Bool {
        return super.isReady && state == .ready
    }
    
    public func isExecuting() -> Bool {
        return super.isExecuting && state == .executing
    }
    
    public func isFinished() -> Bool {
        return super.isFinished && state == .finished
    }
    
    
    override func start() {
        guard !isCancelled else {
            finish()
            return
        }
        
        if !isExecuting {
            state = .executing
        }
        
        main()
    }
    
    func finish() {
        if isExecuting {
            state = .finished
        }
    }
    
    override func cancel() {
        super.cancel()
        
        finish()
    }
    
    func complete(result: NetworkResult) {
        finish()
        
        if !isCancelled {
            completionHandler?(result)
        }
    }
}
