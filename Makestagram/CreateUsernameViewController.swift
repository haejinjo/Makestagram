//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Haejin Jo on 7/6/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
    
    // MARK: - Subviews
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 6
    }
    
    
    // MARK: - IBActions
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        //create new user in database/user account here
        
        // Check that a FIRUser is logged in and that user has provided username in text field
        guard let firUser = Auth.auth().currentUser,
        let username = usernameTextField.text,
            !username.isEmpty else {return}

        UserService.create(firUser, username: username) { (user) in
            guard let user = user
            else {
                //handle error
                return
            }
            
            User.setCurrent(user)
            
            // Check that the storyboard has an initial view controller
            let initialViewController = UIStoryboard.initialViewController(for: .main)
               
                // Get ref to current window and set rootViewController to initial view controller
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()

            print("Created new user: \(user.username)")
        }
    }
}
