//
//  CoffeeDetail.swift
//  Coffee App
//
//  Created by Tim Lee on 10/3/15.
//  Copyright © 2015 Tim Lee. All rights reserved.
//

import Foundation

class CoffeeDetail: NSObject, NSCoding {
    let id: String
    let name: String
    let desc: String
    let imageUrl: String
    let dateUpdated: NSDate
    
    init(id: String, name: String, desc:String, imageUrl:String, dateUpdated:NSDate, image_data:NSData?=nil) {
        self.id = id
        self.name = name
        self.desc = desc
        self.imageUrl = imageUrl
        self.dateUpdated = dateUpdated
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let id = decoder.decodeObjectForKey("id") as? String,
            let name = decoder.decodeObjectForKey("name") as? String,
            let desc = decoder.decodeObjectForKey("desc") as? String,
            let imageUrl = decoder.decodeObjectForKey("image_url") as? String,
            let dateUpdated = decoder.decodeObjectForKey("date_updated") as? NSDate
            else { return nil }
        
        self.init(
            id: id,
            name: name,
            desc: desc,
            imageUrl: imageUrl,
            dateUpdated: dateUpdated
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.id, forKey: "id")
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeObject(self.desc, forKey: "desc")
        coder.encodeObject(self.imageUrl, forKey: "image_url")
        coder.encodeObject(self.dateUpdated, forKey: "date_updated")
    }
}