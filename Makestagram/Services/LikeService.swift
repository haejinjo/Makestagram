//
//  LikeService.swift
//  Makestagram
//
//  Created by Haejin Jo on 7/10/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import FirebaseDatabase


//NOTE: success callback returns Bool on whether network request was well-executed and our like data was saved to the database
struct LikeService {

    static func create(for post: Post, success: @escaping (Bool) -> Void) {
        
        // Each likeable post must have a key. If it doesn't, we take note
        guard let key = post.key else {
            return success(false)
        }
        
        // Reference to current user's ID, need 4 building location of where we'll store post-liking data
        let currentUID = User.current.uid
        
        // CODE 4 WRITING LIKING-POST-DATA TO OUR DATABASE
        
            //1 Define a location for where we plan to write our data
        let likesRef = Database.database().reference().child("postLikes").child(key).child(currentUID)
        
            //2 Write data by setting value of location we've specified 
            //3 Handle a callback for the success of the write
        likesRef.setValue(true) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return success(false)
            }
            return success(true)
        }
        
    } // end of create
    
    
    static func delete(for post: Post, success: @escaping (Bool) -> Void) {
        guard let key = post.key else {
            return success(false)
        }
        
        let currentUID = User.current.uid
        
        let likesRef = Database.database().reference().child("postLikes").child(key).child(currentUID)
        
        // Set value of location to nil, effectively deleting the current node at that location
        likesRef.setValue(nil) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return success(false)
            }
            return success(true)
        }
    }
    
} // end of LikeService struct
