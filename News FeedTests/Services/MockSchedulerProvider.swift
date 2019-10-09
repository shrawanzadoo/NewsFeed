//
//  MockSchedulerProvider.swift
//  News FeedTests
//
//  Created by Shrawan Zadoo on 09/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift
@testable import News_Feed

class MockSchedulerProvider: SchedulerProvider {
  func ui() -> ImmediateSchedulerType {
    return CurrentThreadScheduler.instance
  }
  
  func trampoline() -> ImmediateSchedulerType {
    return CurrentThreadScheduler.instance
  }
  
  func io() -> ImmediateSchedulerType {
    return CurrentThreadScheduler.instance
  }
}

