//
//  CoffeeImage.swift
//  Coffee App
//
//  Created by Tim Lee on 10/3/15.
//  Copyright © 2015 Tim Lee. All rights reserved.
//

import Foundation

class CoffeeImage: NSObject, NSCoding {
    let id: String
    let imageData: NSData

    init(id: String, imageData:NSData) {
        self.id = id
        self.imageData = imageData
    }
        
    required convenience init?(coder decoder: NSCoder) {
        guard let id = decoder.decodeObjectForKey("id") as? String,
            let imageData = decoder.decodeObjectForKey("image_data") as? NSData
            else { return nil }
        
        self.init(
            id: id,
            imageData: imageData
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.id, forKey: "id")
        coder.encodeObject(self.imageData, forKey: "image_data")
    }
}