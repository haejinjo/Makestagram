//
//  UserService.swift
//  Makestagram
//
//  Created by Haejin Jo on 7/6/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct UserService {
    // insert user-related networking code here
    
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
       
         // Create dictionary to store username the user has given into our database
        let userAttrs = ["username": username]
        
        
        // Specify relative path for location of where we want to store this data
        let ref = Database.database().reference().child("users").child(firUser.uid)
        
        // Write this data to the location specified in ref variable
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            // Read the user we just wrote to database and create a User from the snapshot
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
                
                // Now, whenever a user creates an account, a user JSON object will be created for them within the database
            })
        }
    }
}