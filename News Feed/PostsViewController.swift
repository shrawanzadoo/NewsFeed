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

    var posts: PostsRemote?
    var users: UsersRemote?
    var comments: CommentsRemote?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        // Do any additional setup after loading the view.
        
        let dao: DataAccessObject = DataAccessObjectImpl()
        
        _ = dao.fetchPosts()
            .subscribeOn(AppSchedulerProvider().io())
            .observeOn(AppSchedulerProvider().ui()).subscribe(onNext:{ result in
                switch result {
                case .success(let posts):
                    self.posts = posts
                    print("🚨 Posts : \(posts.count)")
                case .failure(let error):
                    print(error)
                }
            }, onError: { error in
                print(error.localizedDescription)
            })
        
        _ = dao.fetchUsers()
            .subscribeOn(AppSchedulerProvider().io())
            .observeOn(AppSchedulerProvider().ui()).subscribe(onNext: { result in
                switch result {
                case .success(let users):
                    self.users = users
                    print("🚨 Users : \(users.count)")
                case .failure(let error):
                    print(error)
                }
            }, onError: { error in
                print(error.localizedDescription)
            })
        
        _ = dao.fetchComments()
            .subscribeOn(AppSchedulerProvider().io())
            .observeOn(AppSchedulerProvider().ui()).subscribe(onNext: { result in
                switch result {
                case .success(let comments):
                    self.comments = comments
                    print("🚨 Comments : \(comments.count)")
                case .failure(let error):
                    print(error)
                }
            }, onError: { error in
                print(error.localizedDescription)
            })
    }
}

