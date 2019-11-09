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
        
        cell.configureCellWith(model: getPostCard(), true)
        
        FBSnapshotVerifyView(cell)
    }
    
    private func getPostCard() -> PostCard {
        return PostCard(userId: 1, postId: 1, name: "Ram", userName: "Vishnu", email: "vishnu@moksha.com", postTitle: "Vasudev Kutumbakam",
                        postBody: """
        The world is a family
        One is a relative, the other stranger,
        say the small minded.
        The entire world is a family,
        live the magnanimous.

        Be detached,
        be magnanimous,
        lift up your mind, enjoy
        the fruit of Brahmanic freedom.
        """,
                        comments: [
        DisplayComment(id: 1, postId: 2, name: "Bro you rock", email: "lakshman@heaven.com", body: ""),
        DisplayComment(id: 1, postId: 2, name: "Bro you stone", email: "lakshman@heaven.com", body: ""),
        DisplayComment(id: 1, postId: 2, name: "Bro you marble", email: "lakshman@heaven.com", body: ""),
        DisplayComment(id: 1, postId: 2, name: "Bro you granite", email: "lakshman@heaven.com", body: ""),
        DisplayComment(id: 1, postId: 2, name: "Bro you pebble", email: "lakshman@heaven.com", body: "")])
    }
    
}
