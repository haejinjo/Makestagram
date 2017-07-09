//
//  MainTabBarController.swift
//  Makestagram
//
//  Created by Haejin Jo on 7/9/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    let photoHelper = MGPhotoHelper()
    
    let CENTER_BUTTON_TAG = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Need a way to communicate between MainTabBarController and MGPhotoHelper
        // Convenient solution: using a Callback aka a reference to a function
        // As soon as MGPhotoHelper selects an image, will call callback func in MainTabBarController to provide it
        
        // Set a closure aka a function without a name (enclosed in curly braces)
        // This callback (in the form of a closure) receives a UIImage? from MGPhotoHelper
        // "in" keyword marks beginning of actual code of closure
        photoHelper.completionHandler = { image in
            print("handle image")
        }
        
        delegate = self
        tabBar.unselectedItemTintColor = .black
    }
    
}


extension MainTabBarController: UITabBarControllerDelegate {
    

    // Gotta implement the UITabBarControllerDelegate
    // Determines if tab bar will present corresponding UIViewController that the user has selected
    // If true, tab bar will be have as usual, else VC will not be displayed-- which is what we want for photo tab 
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController.tabBarItem.tag == CENTER_BUTTON_TAG {
            // present photo taking action sheet
            photoHelper.presentActionSheet(from: self)
            return false
        }
        return true
    }
}
