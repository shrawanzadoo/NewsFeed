//
//  AppScheduderProvider.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 20/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

protocol SchedulerProvider {
    func ui() -> ImmediateSchedulerType
    func trampoline() -> ImmediateSchedulerType
    func io() -> ImmediateSchedulerType
}

class AppSchedulerProvider: SchedulerProvider {
    
    private let queue: OperationQueue
    
    init(queue: OperationQueue = QueueManager.shared.queue) {
        self.queue = queue
    }
    
    func ui() -> ImmediateSchedulerType {
        return MainScheduler.instance
    }
    
    func trampoline() -> ImmediateSchedulerType {
        return CurrentThreadScheduler.instance
    }
    
    func io() -> ImmediateSchedulerType {
        return OperationQueueScheduler(operationQueue: queue)
    }
    
    
}
