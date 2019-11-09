//
//  PostCardCell.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 12/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import UIKit

class PostCardCell: UITableViewCell {
    
    @IBOutlet private weak var initialsTitle: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var postTitleLabel: UILabel!
    @IBOutlet private weak var postBodyLabel: UILabel!
    @IBOutlet private weak var likeLabel: UILabel!
    @IBOutlet private weak var commentsLabel: UILabel!
    @IBOutlet private weak var commentsDetailLabel: UILabel!
    
    func configureCellWith(model: PostCard, _ test: Bool = false) {
        initialsTitle.text = model.name.first?.description
        nameLabel.text = "👤 \(model.name)"
        emailLabel.text = "📭 \(model.email)"
        postTitleLabel.text = "⌁ \(model.postTitle)"
        postBodyLabel.text = "\(model.postBody)"
        let commentCount = model.comments.count
        if commentCount == 1 {
            commentsLabel.text = "💬 \(model.comments.count) comment"
        } else {
            commentsLabel.text = "💬 \(model.comments.count) comments"
        }
        
        var commentString = ""
        model.comments.forEach { comment in
            commentString += "👤 " + comment.name + "\n\n"
        }
        commentsDetailLabel.text = commentString
        if !test {
            likeLabel.text = "👍 \(Int.random(in: 10..<100)) likes"
        }
    }
    
}
