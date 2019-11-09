//
//  BaseSnapshotTestCase.swift
//  NewsFeedSnapshotTests
//
//  Created by Shrawan Zadoo on 12/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import FBSnapshotTestCase
@testable import News_Feed

class BaseSnapshotTestCase: FBSnapshotTestCase {
    
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if ProcessInfo.processInfo.environment["RECORD_MODE"] != nil {
      self.recordMode = true
    }
  }
}
