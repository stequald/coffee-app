//
//  CoffeeModel.swift
//  Coffee App
//
//  Created by Tim Lee on 10/3/15.
//  Copyright © 2015 Tim Lee. All rights reserved.
//

import Foundation
class CoffeeModel : NSObject {
    
    private let COFFEE_FILE_NAME = "coffeecache"
    private let COFFEE_IMAGE_FILE_NAME = "coffeeImagecache"
    private let COFFEE_DETAIL_FILE_NAME = "coffeeImagecache"
    private var localCachedCoffee:Dictionary<String, Coffee>? = nil
    private var localCachedCoffeeImage:Dictionary<String, CoffeeImage>? = nil
    private var localCachedCoffeeDetail:Dictionary<String, CoffeeDetail>? = nil

    override init() {
        super.init()
        self.loadLocalCachedCoffee()
        self.loadlocalCachedCoffeeImage()
        self.loadlocalCachedCoffeeDetail()
    }
    
    private func getFilePath(fileName: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray
        let documentsDirectory: AnyObject = paths.objectAtIndex(0)
        return documentsDirectory.stringByAppendingPathComponent(fileName)
    }

    private func saveFile(fileName: String, object: AnyObject) {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray
        let documentsDirectory: AnyObject = paths.objectAtIndex(0)
        let filePath = documentsDirectory.stringByAppendingPathComponent(fileName)
        NSKeyedArchiver.archiveRootObject(object, toFile: filePath)
    }
    
    
    private func loadLocalCachedCoffee() {
        self.localCachedCoffee = NSKeyedUnarchiver.unarchiveObjectWithFile(self.getFilePath(COFFEE_FILE_NAME)) as? Dictionary<String, Coffee>
        if self.localCachedCoffee == nil {
            self.localCachedCoffee = Dictionary<String, Coffee>()
        }
    }
    
    func saveLocalCachedCoffee() {
        self.saveFile(COFFEE_FILE_NAME, object: self.localCachedCoffee!)
    }
    
    func getCoffeeArray() -> [Coffee] {
        return Array(self.localCachedCoffee!.values)
    }
    
    func cachedCoffeeCount() -> Int {
        return self.localCachedCoffee!.count
    }
    
    func getCoffee(id:String) -> Coffee? {
        if let coffee = self.localCachedCoffee![id] {
            return coffee
        }
        return nil
    }
    
    func setCoffee(coffee:Coffee) {
        self.localCachedCoffee![coffee.id] = coffee
    }
    
    
    private func loadlocalCachedCoffeeImage() {
        self.localCachedCoffeeImage = NSKeyedUnarchiver.unarchiveObjectWithFile(self.getFilePath(COFFEE_IMAGE_FILE_NAME)) as? Dictionary<String, CoffeeImage>
        if self.localCachedCoffeeImage == nil {
            self.localCachedCoffeeImage = Dictionary<String, CoffeeImage>()
        }
    }
    
    func savelocalCachedCoffeeImage() {
        self.saveFile(COFFEE_IMAGE_FILE_NAME, object: self.localCachedCoffeeImage!)
    }
    
    func cachedCoffeeImageCount() -> Int {
        return self.localCachedCoffeeImage!.count
    }
    
    func getCoffeeImageData(id:String) -> NSData? {
        if let coffeeImage = self.localCachedCoffeeImage![id] {
            return coffeeImage.imageData
        }
        return nil
    }
    
    func setCoffeeImage(coffeeImage:CoffeeImage) {
        self.localCachedCoffeeImage![coffeeImage.id] = coffeeImage
    }
    
    
    private func loadlocalCachedCoffeeDetail() {
        self.localCachedCoffeeDetail = NSKeyedUnarchiver.unarchiveObjectWithFile(self.getFilePath(COFFEE_DETAIL_FILE_NAME)) as? Dictionary<String, CoffeeDetail>
        if self.localCachedCoffeeDetail == nil {
            self.localCachedCoffeeDetail = Dictionary<String, CoffeeDetail>()
        }
    }
    
    func savelocalCachedCoffeeDetail() {
        self.saveFile(COFFEE_DETAIL_FILE_NAME, object: self.localCachedCoffeeDetail!)
    }
    
    func cachedCoffeeDetailCount() -> Int {
        return self.localCachedCoffeeDetail!.count
    }
    
    func getCoffeeDetail(id:String) -> CoffeeDetail? {
        if let coffeeDetail = self.localCachedCoffeeDetail![id] {
            return coffeeDetail
        }
        return nil
    }
    
    func setCoffeeDetail(coffeeDetail:CoffeeDetail) {
        self.localCachedCoffeeDetail![coffeeDetail.id] = coffeeDetail
    }
}