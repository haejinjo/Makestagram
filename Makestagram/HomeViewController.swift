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
    
    let timestampFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        return dateFormatter
    }()
    
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
        return 3 // to correspond with header, img, and action cells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.section]
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostHeaderCell", for: indexPath) as! PostHeaderCell
            
            cell.usernameLabel.text = User.current.username
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell", for: indexPath) as! PostImageCell
            let imageURL = URL(string: post.imageURL)
            cell.postImageView.kf.setImage(with: imageURL)
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostActionCell", for: indexPath) as! PostActionCell
            
            cell.timeAgoLabel.text = timestampFormatter.string(from: post.creationDate)
            
            return cell
            
        default:
            fatalError("Error: unexpected indexPath")
        } // end switch
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
}

//MARK: - UITableViewDelegate


extension HomeViewController: UITableViewDelegate {
   
    // Method that returns the height that each cell should be, given an index path
    // Allows us to have cells with varying heights within the same table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return PostHeaderCell.height
        case 1:
            let post = posts[indexPath.section]
            return post.imageHeight
            
        case 2:
            return PostActionCell.height
            
        default:
            fatalError()
        }
    }
}

