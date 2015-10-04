//
//  CoffeeDetailTableViewController.swift
//  Coffee App
//
//  Created by Tim Lee on 10/3/15.
//  Copyright © 2015 Tim Lee. All rights reserved.
//

import Foundation

class CoffeeDetailTableViewController: UITableViewController {
    
    var coffeeID:String? = nil
    var coffeeName:String? = nil
    var coffeeDetailObject:Dictionary<String, String>? = nil

    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = AppIconUtils.getNavbarIcon()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.estimatedRowHeight = 600
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.allowsSelection = false
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        let rightBarButtonItem = UIButton()
        rightBarButtonItem.titleLabel?.font = UIFont.boldSystemFontOfSize((rightBarButtonItem.titleLabel?.font.pointSize)!);
        rightBarButtonItem.setTitle("SHARE", forState: .Normal)
        rightBarButtonItem.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        rightBarButtonItem.frame = CGRectMake(0, 0, 70, 30)
        rightBarButtonItem.layer.borderColor = UIColor.whiteColor().CGColor
        rightBarButtonItem.layer.borderWidth = 2
        rightBarButtonItem.addTarget(self, action: "shareButtonClicked", forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButtonItem)
    }
    
    func shareButtonClicked() {
        let av = UIAlertView(title: "Share Button Clicked",
            message: nil,
            delegate: nil,
            cancelButtonTitle: "OK")
        av.show()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let MyIdentifier = "CoffeeNameCellIdentifier"
            var cell = tableView.dequeueReusableCellWithIdentifier(MyIdentifier) as! CoffeeNameTableViewCell?
            if (cell == nil) {
                cell = UITableViewCell(style: UITableViewCellStyle.Default,
                    reuseIdentifier: MyIdentifier) as? CoffeeNameTableViewCell
            }
            cell!.nameLabel!.translatesAutoresizingMaskIntoConstraints = false
            cell!.nameLabel!.textColor = UIColor(netHex: 0x666666)
            cell!.nameLabel!.font = UIFont(name: cell!.nameLabel!.font.fontName, size: 26)
            cell!.nameLabel!.text = self.coffeeName
            
            return cell!
        } else {
            let MyIdentifier = "CoffeeDetailCellIdentifier"
            var cell = tableView.dequeueReusableCellWithIdentifier(MyIdentifier) as! CoffeeDetailTableViewCell?
            if (cell == nil) {
                cell = UITableViewCell(style: UITableViewCellStyle.Default,
                    reuseIdentifier: MyIdentifier) as? CoffeeDetailTableViewCell
            }
            // Hide bottom separator
            cell!.separatorInset = UIEdgeInsetsMake(0, 0, 0, CGRectGetWidth(tableView.bounds));

            if self.coffeeID == nil {
                return cell!
            }

            AppDelegate.instance().coffeeAPI!.getCoffeeDetails(self.coffeeID!, success: {
                (jsonData: AnyObject!) in
                NSLog("jsonDatajsonData \(jsonData.description)")
                self.coffeeDetailObject = jsonData as? Dictionary<String, String>
                cell!.descriptionLabel?.text = jsonData["desc"] as? String
                cell!.descriptionLabel?.sizeToFit()
                
                var imageUrl = jsonData["image_url"] as? String
                imageUrl = imageUrl!.replace("http://", withString:"https://")
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss.SSSSSS"
                let date = dateFormatter.dateFromString(jsonData["last_updated_at"] as! String)
                cell!.lastUpdatedLabel?.text = "Updated " + date!.timeAgo()
                tableView.reloadData()
                AppDelegate.instance().coffeeModel!.setCoffeeDetail(CoffeeDetail(
                    id: self.coffeeID!,
                    name: jsonData["name"] as! String,
                    desc: jsonData["desc"] as! String,
                    imageUrl: imageUrl!,
                    dateUpdated: date!)
                )
                AppDelegate.instance().coffeeModel!.savelocalCachedCoffeeDetail()
                
                if imageUrl != nil && imageUrl != "" {
                    let url = NSURL(string: imageUrl!)!
                    let imageGetManager = AFHTTPRequestOperationManager()
                    imageGetManager.responseSerializer = AFImageResponseSerializer()
                    imageGetManager.GET(url.absoluteString,
                        parameters:nil,
                        success:{(operation:AFHTTPRequestOperation!, responseObject:AnyObject!) in
                            
                            cell!.coffeeImageView?.image = responseObject as? UIImage
                            AppDelegate.instance().coffeeModel!.setCoffeeImage(CoffeeImage(id: self.coffeeID!,
                                imageData: UIImageJPEGRepresentation(cell!.coffeeImageView!.image!, 1)!))
                            AppDelegate.instance().coffeeModel!.savelocalCachedCoffeeDetail()
                            
                            tableView.reloadData()
                            
                        } ,
                        failure:{(operation:AFHTTPRequestOperation!, error:NSError!) in
                            if let imageData = AppDelegate.instance().coffeeModel!.getCoffeeImageData(self.coffeeID!) {
                                cell!.coffeeImageView?.image = UIImage(data: imageData)
                                tableView.reloadData()
                            }
                    })
                }
                }, failure: {
                    (code: NSInteger, status: String!) in
                    if let coffeeDetail = AppDelegate.instance().coffeeModel?.getCoffeeDetail(self.coffeeID!) {
                        if let coffeeImageData = AppDelegate.instance().coffeeModel?.getCoffeeImageData(self.coffeeID!) {
                            cell!.coffeeImageView?.image = UIImage(data: coffeeImageData)
                        }
                        cell!.descriptionLabel?.text = coffeeDetail.desc
                        cell!.descriptionLabel?.sizeToFit()
                        cell!.lastUpdatedLabel?.text = "Updated " + coffeeDetail.dateUpdated.timeAgo()
                        tableView.reloadData()
                    }
            })
            
            return cell!
        }
    }
}