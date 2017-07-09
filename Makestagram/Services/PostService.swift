//
//  PostService.swift
//  Makestagram
//
//  Created by Haejin Jo on 7/9/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase

struct PostService {
    
    // create static method within the new service for creating a Post from an image
    
    static func create(for image: UIImage) {
        let imageRef = Storage.storage().reference().child("test_image.jpg")
        
        StorageService.uploadimage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL
                else {
                    return
            }
            
            let urlString = downloadURL.absoluteString
            print("image url: \(urlString)")
        }
    }
}
