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

    @IBOutlet private weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    var presenter: NewsFeedPresenterContract?
    
    var dataSource: [PostCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        
        presenter = Injection.shared.newsFeedPresenter
        
        presenter?.takeView(self)
        presenter?.getNewsFeed()
        
        tableView.registerTableViewCellNib(PostCardCell.self)
        tableView.addSubview(refreshControl)
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshData(_ sender: Any) {
        presenter?.getNewsFeed()
    }
}

extension PostsViewController: NewsFeedViewContract {
    
    func setPresenter(presenter: NewsFeedPresenterContract) {
        self.presenter = presenter
    }
    
    func updateNewsFeed(postCards: [PostCard]?) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            if let postCards = postCards {
                self.dataSource = postCards
                self.tableView.reloadData()
            }
        }
    }
    
    func showError() {
        
    }
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = PostCardCell.reuseIdentifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? PostCardCell else {
            fatalError("Could not dequeue PostCardCell with identifier \(cellIdentifier)")
        }

        cell.configureCellWith(model: dataSource[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
