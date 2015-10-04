//
//  AppIconUtils.swift
//  Coffee App
//
//  Created by Tim Lee on 10/3/15.
//  Copyright © 2015 Tim Lee. All rights reserved.
//

import Foundation

class AppIconUtils {
    
    class func getNavbarIcon() -> UIImageView {
        let image = UIImage(named: "drip-white")
        let imageView = UIImageView(frame:CGRectMake(0, 0, 160, 30))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = image
        return imageView
    }
}