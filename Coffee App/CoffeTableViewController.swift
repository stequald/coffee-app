//
//  CoffeTableViewController.swift
//  Coffee App
//
//  Created by Tim Lee on 10/3/15.
//  Copyright © 2015 Tim Lee. All rights reserved.
//

import UIKit

class CoffeTableViewController: UITableViewController {

    var selectedCoffeeIdx = 0
    var imageViewConstraints:[String:NSLayoutConstraint] = [String:NSLayoutConstraint]()
    var latestCoffeeArray:[AnyObject] = [];
    var latestCoffeeImage:[String:UIImage] = [String:UIImage]();
    let COFFEE_THUMBNAIL_MAX_SCALE_HEIGHT:CGFloat = 200.0
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = AppIconUtils.getNavbarIcon()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.translatesAutoresizingMaskIntoConstraints = false

        self.navigationItem.title = nil;
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0xF16421)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.fetchCoffeeData()
    }
    
    func fetchCoffeeData() {
        AppDelegate.instance().coffeeAPI!.getCoffeeList({
            (jsonData: AnyObject!) in
            
            self.latestCoffeeArray = jsonData as! [AnyObject]
            self.tableView.reloadData()
            self.updateLocalCoffeeCache(self.latestCoffeeArray)
            }, failure: {
                (code: NSInteger, status: String!) in
                
                let coffeeArray = AppDelegate.instance().coffeeModel?.getCoffeeArray()
                for coffee in coffeeArray! {
                    self.latestCoffeeArray.append([
                        "id": coffee.id,
                        "name": coffee.name,
                        "desc": coffee.desc,
                        "image_url": coffee.imageUrl,
                        ])
                    
                    if let imageData = AppDelegate.instance().coffeeModel?.getCoffeeImageData(coffee.id) {
                        self.latestCoffeeImage[coffee.id] = UIImage(data: imageData)!.rescaleImageWithinHeight(self.COFFEE_THUMBNAIL_MAX_SCALE_HEIGHT)
                    }
                }
                self.tableView.reloadData()
        })
    }
    
    
    func updateLocalCoffeeCache(coffeeArray:[AnyObject]) {
        for coffee in coffeeArray {
            AppDelegate.instance().coffeeModel!.setCoffee(Coffee(
                id: coffee["id"] as! String,
                name: coffee["name"] as! String,
                desc: coffee["desc"] as! String,
                imageUrl: coffee["image_url"] as! String
                ))
        }
        AppDelegate.instance().coffeeModel!.saveLocalCachedCoffee()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender:AnyObject!) -> () {
        if (segue.identifier == "SegueDetails") {
            let coffeeDetailTableViewController = segue.destinationViewController as! CoffeeDetailTableViewController
            var coffee = self.latestCoffeeArray[self.selectedCoffeeIdx] as! Dictionary<String, String>
            coffeeDetailTableViewController.coffeeID = coffee["id"]!
            coffeeDetailTableViewController.coffeeName = coffee["name"]!
            coffeeDetailTableViewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil);
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.latestCoffeeArray.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let MyIdentifier = "CoffeeCellIdentifier"
        var cell = tableView.dequeueReusableCellWithIdentifier(MyIdentifier) as! CoffeeTableViewCell?
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default,
                reuseIdentifier: MyIdentifier) as? CoffeeTableViewCell
        }
        
        var coffee = self.latestCoffeeArray[indexPath.row] as! Dictionary<String, String>
        let name = coffee["name"]!
        let desc = coffee["desc"]!
        cell!.coffeeNameLabel!.text = name;
        cell!.coffeeDescLabel!.text = desc;

        let id = coffee["id"]!
        var imageUrl = coffee["image_url"]!
        imageUrl = imageUrl.replace("http://", withString:"https://")

        if self.latestCoffeeImage[id] != nil {
            cell!.coffeeImageView!.image = self.latestCoffeeImage[id]!.rescaleImageWithinHeight(self.COFFEE_THUMBNAIL_MAX_SCALE_HEIGHT)
        } else if imageUrl != "" {
           cell!.coffeeImageView!.setImageWithURLRequest(NSURLRequest(URL: NSURL(string: imageUrl)!), placeholderImage: UIImage(),
                success: { (urlRequest: NSURLRequest!, HTTPURLResponse: NSHTTPURLResponse!, image:UIImage!) -> Void in
                    self.latestCoffeeImage[id] = image.rescaleImageWithinHeight(self.COFFEE_THUMBNAIL_MAX_SCALE_HEIGHT)
                    cell!.coffeeImageView!.image = image
                    self.tableView.reloadData()

                    AppDelegate.instance().coffeeModel!.setCoffeeImage(CoffeeImage(id: id,
                        imageData: UIImageJPEGRepresentation(image, 1)!))
                    AppDelegate.instance().coffeeModel!.savelocalCachedCoffeeImage()
                }) { (urlRequest: NSURLRequest!, HTTPURLResponse: NSHTTPURLResponse!, error: NSError!) -> Void in
                    if let imageData = AppDelegate.instance().coffeeModel!.getCoffeeImageData(id) {
                        cell!.coffeeImageView!.image = UIImage(data: imageData)!.rescaleImageWithinHeight(self.COFFEE_THUMBNAIL_MAX_SCALE_HEIGHT)
                        self.tableView.reloadData()
                    }
            }
        } else {
            if let imageData = AppDelegate.instance().coffeeModel!.getCoffeeImageData(id) {
                cell!.coffeeImageView!.image = UIImage(data: imageData)!.rescaleImageWithinHeight(self.COFFEE_THUMBNAIL_MAX_SCALE_HEIGHT)
            } else {
                cell!.coffeeImageView!.image = nil
            }
        }

        return cell!
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        self.selectedCoffeeIdx = indexPath.row
        performSegueWithIdentifier("SegueDetails", sender:self)
        return nil
    }
}

