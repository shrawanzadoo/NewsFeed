//
//  NewsFeedPresenter.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 12/10/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation
import RxSwift

class NewsFeedPresenter: NewsFeedPresenterContract {
    
    var disposeBag = DisposeBag()
    let scheduler: SchedulerProvider
    
    let getPostsUseCase: GetPosts
    let getUsersUseCase: GetUsers
    let getCommentsUseCase: GetComments
    
    var view: NewsFeedViewContract?
    
    init(scheduler: SchedulerProvider = AppSchedulerProvider(),
         getPostsUseCase: GetPosts = GetPosts(),
         getUsersUseCase: GetUsers = GetUsers(),
         getCommentsUseCase: GetComments = GetComments()) {
        self.scheduler = scheduler
        self.getPostsUseCase = getPostsUseCase
        self.getUsersUseCase = getUsersUseCase
        self.getCommentsUseCase = getCommentsUseCase
    }
    
    func takeView(_ view: NewsFeedViewContract) {
        self.view = view
    }
    
    func getNewsFeed() {
        Observable
            .combineLatest(getCommentsUseCase.execute(""), getPostsUseCase.execute(""), getUsersUseCase.execute("")) { (commentsResponse, postsResponse, usersResponse) -> [PostCard]? in
                var postCards: [PostCard] = []
                
                if let posts = self.processResponse(postsResponse),
                    let users = self.processResponse(usersResponse),
                    let comments = self.processResponse(commentsResponse) {
                    
                    posts.forEach { post in
                        
                        // user for the post
                        if let userForPost = users.first(where: { $0.id == post.userId }) {
                            
                            var displayComments: [DisplayComment] = []
                            // comments for the post
                            let commentsForPost = comments.filter({ $0.postId == post.id })
                            commentsForPost.forEach { comment in
                                displayComments.append(DisplayComment(id: comment.id,
                                                                      postId: comment.postId,
                                                                      name: comment.name,
                                                                      email: comment.email,
                                                                      body: comment.body))
                            }
                            
                            postCards.append(PostCard(userId: post.userId,
                                                      postId: post.id,
                                                      name: userForPost.name,
                                                      userName: userForPost.username,
                                                      email: userForPost.email,
                                                      postTitle: post.title,
                                                      postBody: post.body,
                                                      comments: displayComments))
                        }
                    }
                    return postCards
                }
                return nil
        }
        .subscribeOn(scheduler.ui())
        .observeOn(scheduler.io())
        .subscribe(onNext: { postCards in
            self.view?.updateNewsFeed(postCards: postCards)
        }).disposed(by: disposeBag)
    }
    
    private func processResponse<T: Any>(_ response: Result<[T], Error>) -> [T]? {
        switch response {
        case .success(let result):
            return result
        case .failure(let error):
            handleError(error)
            return nil
        }
    }
    
    private func handleError(_ error: Error) {
        
    }
}
