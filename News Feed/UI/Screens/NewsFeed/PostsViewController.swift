//
//  ViewController.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 07/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import UIKit
import RxSwift

class PostsViewController: UIViewController {

    var presenter: NewsFeedPresenterContract?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
    }
}

extension PostsViewController: NewsFeedViewContract {
    func updateNewsFeed(postCards: [PostCard]) {
        
    }
    
    func showError() {
        
    }
    
    
}
