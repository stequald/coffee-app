
//
//  UIImageExtension.swift
//  Coffee App
//
//  Created by Tim Lee on 10/3/15.
//  Copyright © 2015 Tim Lee. All rights reserved.
//

import Foundation

extension UIImage {
    func rescaleImageWithinHeight(withinHeight: CGFloat) -> UIImage {
        if self.size.height < withinHeight {
            return self
        }
        let oldHeight = self.size.height
        let scaleFactor = withinHeight / oldHeight
        
        let newWidth = self.size.width * scaleFactor
        let newHeight = oldHeight * scaleFactor
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        self.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}