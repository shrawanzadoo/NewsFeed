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
        
        presenter?.takeView(self)
        presenter?.getNewsFeed()
    }
}

extension PostsViewController: NewsFeedViewContract {
    
    func setPresenter(presenter: NewsFeedPresenterContract) {
        self.presenter = presenter
    }
    
    func updateNewsFeed(postCards: [PostCard]) {
        
    }
    
    func showError() {
        
    }
    
    
}
