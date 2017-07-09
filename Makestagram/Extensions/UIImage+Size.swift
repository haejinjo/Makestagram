//
//  UIImage+Size.swift
//  Makestagram
//
//  Created by Haejin Jo on 7/9/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import Foundation
import UIKit

// Added a computed property of aspect height to UIImage
extension UIImage {
    var aspectHeight: CGFloat {
        let heightRatio = size.height / 736
        let widthRatio = size.width/414
        let aspectRatio = fmax(heightRatio, widthRatio)
        
        // Will calculate aspect height for an instance of UIImage based on size property of the image
        return size.height/aspectRatio
    }
}
