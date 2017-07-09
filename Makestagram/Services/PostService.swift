//
//  PostService.swift
//  Makestagram
//
//  Created by Haejin Jo on 7/9/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase

struct PostService {
    
    // create static method within the new service for creating a Post from an image
    
    static func create(for image: UIImage) {
        let imageRef = StorageReference.newPostImageReference()
        
        StorageService.uploadimage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL
                else {
                    return
            }
            
            let urlString = downloadURL.absoluteString
            let aspectHeight = image.aspectHeight
            create(forURLString: urlString, aspectHeight: aspectHeight)
            print("image url: \(urlString)")
        }
    }
    
    // Create new Post JSON object in our database
    private static func create(forURLString urlString: String, aspectHeight: CGFloat) {
        
        
        // Create reference to the current user, need UID to construct location of where we'll store post data in DB
        let currentUser = User.current
        
        // Initialize new post using params
        let post = Post(imageURL: urlString, imageHeight: aspectHeight)
        
        // Convert new post object into dictionary so it can be written as JSON in our DB
        let dict = post.dictValue
        
        // Construct relative path to location where we wanna store new post data
        // using current user's id as child nodes to keep track of which posts belong to which user
        let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
        
        // Write the data to the specified location
        postRef.updateChildValues(dict)
    }
}
