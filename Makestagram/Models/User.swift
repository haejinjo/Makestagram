//
//  User.swift
//  Makestagram
//
//  Created by Haejin Jo on 7/5/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

// MADE THIS DATA MODEL BECAUSE FETCHING USER INFO AS A DICT IS VERY ERROR-PRONE
// BC IT FORCES US TO RETRIEVE VALUES WITH KEYS THAT ARE STRINGS

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class User {
    
    // MARK: - Properties
    
    let uid: String
    let username: String
    
    // MARK: - Init
    
    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
    }
    
    // MARK: - Failable Init 
    // (returns nil if user doesn't have UID or username)
    // Can use to cleanly create User objects from snapshots
    init?(snapshot: DataSnapshot) {
        
        // guard statement: IF EIThER OF THESE 2 CONDITIONS FAIL, RETURN NIL
        // 1) Require snapshot be casted to NSdDictionary
        // 2) Check that the dict contains username key/value pair
        guard let dict = snapshot.value as? [String: Any?], 
            // Store key property of DataSnapshot (the UID corresponding to the user being initialized)
            let username = dict["username"] as? String
            else {return nil}
        
        self.uid = snapshot.key
        self.username = username
    }
    
    // MARK: - Singleton
    
    //Create private static variable to hold our current user (cannot be accessed outside of User class)
    private static var _current: User?
    
    // Create a computed variable that only has a getter func that enables access to private _current variable
    static var current: User {
        
        // Check that _current of type User? isn't nil
        guard let currentUser = _current
        else {
            fatalError("Error: current user doesn't exist")
        }
        
        // If _current isn't nil, will be returned to the user
        return currentUser
    }
    
    // MARK: - Class Methods
    
    // Create a custom setter method to set the current user
    static func setCurrent(_ user: User) {
        _current = user
    }
}
