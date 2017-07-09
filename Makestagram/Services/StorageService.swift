//
//  StorageService.swift
//  Makestagram
//
//  Created by Haejin Jo on 7/9/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

// Interface between our app and FirebaseStorage 


struct StorageService {
    
    static func uploadimage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        
        // Change from UIImage to Data AND reduce img quality to take less time uploading/downloading from firebase
        guard let imageData = UIImageJPEGRepresentation(image, 0.1)
            // If you can't convert to Data, return nil to completion callback to signal something went wrong
            else {
                return completion(nil)
        }
        
        // Upload our media data to the path provided in params of uploadImage function
        reference.putData(imageData, metadata: nil, completion: {(metadata, error) in
           // After upload completes error check, crash and give message if smoething went wrong
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            // If successful, return the download URL for the image 
            completion(metadata?.downloadURL())
        })
    }
}
