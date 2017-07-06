//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Haejin Jo on 7/5/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase

// like a typedef! Now we can use FIRUser in place of the longer FirebaseAuth.User type
typealias FIRUser = FirebaseAuth.User


class LoginViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Do any additional setup after loading the view
    }
    
    // MARK: - IBActions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        // Access FUIAuth default auth UI singleton 
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        // Set the FUIAuth's singleton's delegate
        authUI.delegate = self
        
        // Present the auth view controller
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
        
        print("login button tapped")
    }
}

extension LoginViewController: FUIAuthDelegate {
    
    //Param: FirebaseAuth user that was authenticated and/or an error that occurred
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        
        // Whenever there's an error in development, app will crash w/ formatted message of what went wrong
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        
        // Check that FIRUser is here/not nil by unwrapping
        // guard --> don't proceed if user is nil, b/c we need FIRUser object's UID property to build the rel path @ /users/uid#
        guard let user = user
            else {return}
        
        // Construct a relative path to the reference of the user's info in our database
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        
        
        // Read from the path we created, pass EVENT CLOSURE to handle the data snapshot passed back from the database
        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
            
            // To retrieve user data from DataSnapshot, 
            // Check if snapshot exists by unwrapping and is the datatype we expect!
            // (here, we expect user to be returned as an NSDictionary so we specify that; remember JSON tutorial?)
            if let user = User(snapshot: snapshot) {
                
                // Set the user singleton using custom setter method we wrote
                User.setCurrent(user)
                
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                
                if let initialViewController = storyboard.instantiateInitialViewController() {
                    self.view.window?.rootViewController = initialViewController
                    self.view.window?.makeKeyAndVisible()
                }
                
                print("Welcome back, \(user.username).")
            }
            //Else, current user dict does not exist in the database
            else {
                // Take the newbie to create a username!
                self.performSegue(withIdentifier: "toCreateUsername" , sender: self)
            }
        })
        
        print("handle user signup/login")
    }
}
