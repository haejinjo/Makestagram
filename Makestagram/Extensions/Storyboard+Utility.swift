//
//  Storyboard+Utility.swift
//  Makestagram
//
//  Created by Haejin Jo on 7/6/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    // enum created by our app, MakestaGram (avoid potential namespace conflicts with Apple/3rdparty libs)
    enum MGType: String {
       
        //case per each of the app's storyboards
        case main
        case login
        
        // Create computed variable that capitalizes rawvalue of each case (e.g. "Main", "Login")
        // So, this var will return the corresponding filename for each storyboard
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    // Allows us to initialize the correct storyboard based on each custom enum case
    convenience init(type: MGType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initialViewController(for type: MGType) -> UIViewController {
        let storyboard = UIStoryboard(type: type) //using our convenience initializer
        
        guard let initialViewController = storyboard.instantiateInitialViewController()
        else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }
        return initialViewController
    }
}
