//
//  PostCardCellTests.swift
//  NewsFeedSnapshotTests
//
//  Created by Shrawan Zadoo on 12/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import FBSnapshotTestCase
@testable import News_Feed

class PostCardCellTests: BaseSnapshotTestCase {
  func test_PostCardCell() {
    guard let cell = PostCardCell.loadFromNib() else {
        XCTFail("Failed to generate the view of PostCardCell")
        return
    }

    FBSnapshotVerifyView(cell)
  }
}
