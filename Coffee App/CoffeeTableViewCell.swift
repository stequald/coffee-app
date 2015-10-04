//
//  CoffeeTableViewCell.swift
//  Coffee App
//
//  Created by Tim Lee on 10/3/15.
//  Copyright © 2015 Tim Lee. All rights reserved.
//

import Foundation

class CoffeeTableViewCell:UITableViewCell {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    var coffeeNameLabel: UILabel?
    var coffeeDescLabel: UILabel?
    var coffeeImageView:UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        self.coffeeNameLabel = UILabel()
        self.coffeeNameLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.coffeeNameLabel?.textColor = UIColor(netHex: 0x666666)

        self.coffeeDescLabel = UILabel()
        self.coffeeDescLabel!.font = UIFont(name: self.coffeeDescLabel!.font.fontName, size: 12)
        self.coffeeDescLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.coffeeDescLabel?.textColor = UIColor(netHex: 0xAAAAAA)
        self.coffeeDescLabel?.numberOfLines = 2

        self.accessoryView = UIImageView(image: UIImage(named: "disclosure_indicator.jpg"))
        self.accessoryView?.translatesAutoresizingMaskIntoConstraints = false
        
        self.coffeeImageView = UIImageView()
        self.coffeeImageView?.translatesAutoresizingMaskIntoConstraints = false
        self.coffeeImageView!.clipsToBounds = true

        self.addSubview(self.coffeeNameLabel!)
        self.addSubview(self.coffeeDescLabel!)
        self.addSubview(self.accessoryView!)
        self.addSubview(self.coffeeImageView!)
        
        self.coffeeNameLabel!.constrainToLeftOfSuperView(16)
        self.coffeeNameLabel!.constrainToRightOfSuperView(8)
        self.coffeeNameLabel!.constrainToTopOfSuperView(8)
        
        self.coffeeDescLabel!.constrainToLeftOfSuperView(16)
        self.addConstraints(self.coffeeDescLabel!.anchorToLeft(self.accessoryView!, padding: 8))
        self.addConstraints(self.coffeeDescLabel!.anchorToBottom(self.coffeeNameLabel!, padding: 8))
        
        self.coffeeImageView!.constrainToLeftOfSuperView(16)
        self.coffeeImageView?.clipsToBounds = true
        self.coffeeImageView?.contentMode = .ScaleAspectFill
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[item(<=height)]",
            metrics: ["height" : 200],
            views: ["item" : self.coffeeImageView!]) as! [NSLayoutConstraint]
        self.coffeeImageView!.superview?.addConstraints(constraints)
        let constraints2 = NSLayoutConstraint.constraintsWithVisualFormat("H:[item]-(>=padding)-|", options: [], metrics: ["padding" : 46], views: ["item" : self.coffeeImageView!])
        self.coffeeImageView!.superview?.addConstraints(constraints2)
        self.addConstraints(self.coffeeImageView!.anchorToBottom(self.coffeeDescLabel!, padding: 8))
        self.coffeeImageView!.constrainToBottomOfSuperView(8)

        self.accessoryView!.constrainToRightOfSuperView(8)
        self.addConstraints(self.accessoryView!.anchorToBottom(self.coffeeNameLabel!, padding: 0))
        self.addConstraints(self.accessoryView!.constrainHeight(50))
        self.addConstraints(self.accessoryView!.constrainWidth(50))
    }
}