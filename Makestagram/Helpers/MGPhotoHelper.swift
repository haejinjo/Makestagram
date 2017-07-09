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
            let capturePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: {[unowned self] action in
            self.presentImagePickerController(with: .camera, from: viewController)
            })
            
            // Add action to alert controller instance we created right before this
            alertController.addAction(capturePhotoAction)
        }
     
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let uploadAction = UIAlertAction(title: "Upload From Library", style: .default, handler: {[unowned self] action in
                self.presentImagePickerController(with: .photoLibrary, from: viewController)
            })
            
            alertController.addAction(uploadAction)
        }
        
        // Allow user to close the UIAlertController action sheet
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        
        // Present UIAlertController from our UIViewController, which we can reference via param of this function
        viewController.present(alertController, animated: true)
    }
    
    func presentImagePickerController(with sourceType: UIImagePickerControllerSourceType, from viewController: UIViewController) {
        
        // Create new instance of UIImagePickerController 
        // This object will present a native UI component that allows user to take photo from camera or choose from lib
        let imagePickerController = UIImagePickerController()
        
        // set source type specified by func param to determine whether image picker controller will display photo-taking overlay or user's library
        imagePickerController.sourceType = sourceType
        
        
        // To be a delegate of a UIImagePickerController -> implement UIImagePickerControllerDelegate protocol (all of UINavigationControllerDelegate protocol's methods are optional, so don't need to implement ;P )
        imagePickerController.delegate = self
        
        // Once imagepickercontroller is initialized/configured, we present the view controller!
        viewController.present(imagePickerController, animated: true)
    }
}

extension MGPhotoHelper: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // Called when image is selected
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Check the info dictionary to see if we were passed back an image
        // If info dict contains an image, we pass to our completionHandler property
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            completionHandler?(selectedImage)
        }
        
        // Dismiss image picker controller regardless 
        picker.dismiss(animated: true)
    }
    
    // Because we're the delegate of UIImagePickerController now, we have to manually call dismiss on the picker object when cancel button is tapped in order to hide the imagePickerController
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
