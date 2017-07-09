//
//  MGPhotoHelper.swift
//  Makestagram
//
//  Created by Haejin Jo on 7/9/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import UIKit

class MGPhotoHelper: NSObject {
    
    // MARK: - Properties
    
    var completionHandler: ((UIImage) -> Void)?
    
    // MARK: - Helper Methods
    
    func presentActionSheet(from viewController: UIViewController) {
        
        // UI Alert Controllers can be used to prsent different types of alerts
        // Action sheets = popups displayed at bottom of screen
        
        
        // Initialize a new UIAlertController of type actionsheet
        let alertController = UIAlertController(title: nil, message: "Where do you want to get your photo from?", preferredStyle: .actionSheet)
        
        // Check if current device has a camera (if its simulator, then this won't be triggered)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            // Create new UIAlertAction (one of the buttons on the UIAlertController
            // can provide title, style, and handler that will execute when action is selected
            let capturePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: {action in
            // do something in the completion block
            })
            
            // Add action to alert controller instance we created right before this
            alertController.addAction(capturePhotoAction)
        }
     
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let uploadAction = UIAlertAction(title: "Upload From Library", style: .default, handler: { action in
                // do something eventually
            })
            
            alertController.addAction(uploadAction)
        }
        
        // Allow user to close the UIAlertController action sheet
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        
        // Present UIAlertController from our UIViewController, which we can reference via param of this function
        viewController.present(alertController, animated: true)
    }
}
