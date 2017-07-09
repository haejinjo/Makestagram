//
//  HomeViewController.swift
//  Makestagram
//
//  Created by Haejin Jo on 7/7/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    

    // MARK: - Subviews
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var posts = [Post]()
    
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fetch posts from database
        UserService.posts(for: User.current) { (posts) in
            self.posts = posts
            self.tableView.reloadData()
        }
        
        configureTableView()
    }
    
    func configureTableView() {
        // remove separators for empty cells
        tableView.tableFooterView = UIView()
        
        // remove separatos for cells
        tableView.separatorStyle = .none
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell", for: indexPath) as! PostImageCell
        
        let imageURL = URL(string: post.imageURL)
        cell.postImageView.kf.setImage(with: imageURL)
        
        
        return cell
    }
}

//MARK: - UITableViewDelegate


extension HomeViewController: UITableViewDelegate {
   
    // Method that returns the height that each cell should be, given an index path
    // Allows us to have cells with varying heights within the same table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let post = posts[indexPath.row]
        
        return post.imageHeight
    }
}

