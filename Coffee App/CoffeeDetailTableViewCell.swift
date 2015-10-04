//
//  CoffeeDetailTableViewCell.swift
//  Coffee App
//
//  Created by Tim Lee on 10/3/15.
//  Copyright © 2015 Tim Lee. All rights reserved.
//

import Foundation

class CoffeeDetailTableViewCell:UITableViewCell {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var descriptionLabel: UILabel?
    var coffeeImageView:UIImageView?
    var lastUpdatedLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        self.descriptionLabel = UILabel()
        self.descriptionLabel?.font = UIFont(name: self.descriptionLabel!.font.fontName, size: 18)
        self.descriptionLabel?.numberOfLines = 0
        self.descriptionLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.descriptionLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel?.textColor = UIColor(netHex: 0xAAAAAA)
        self.descriptionLabel!.setContentHuggingPriority(UILayoutPriorityRequired,
            forAxis:UILayoutConstraintAxis.Vertical)
        self.descriptionLabel!.setContentCompressionResistancePriority(UILayoutPriorityRequired,
            forAxis:UILayoutConstraintAxis.Vertical)
 
        self.coffeeImageView = UIImageView()
        self.coffeeImageView?.translatesAutoresizingMaskIntoConstraints = false
        self.coffeeImageView?.clipsToBounds = true
        
        self.lastUpdatedLabel = UILabel()
        self.lastUpdatedLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.lastUpdatedLabel?.textColor = UIColor(netHex: 0xAAAAAA)
        self.lastUpdatedLabel?.font = UIFont.italicSystemFontOfSize(14)
        
        self.addSubview(self.descriptionLabel!)
        self.addSubview(self.coffeeImageView!)
        self.addSubview(self.lastUpdatedLabel!)
        

        self.descriptionLabel!.constrainToTopOfSuperView(8)
        self.descriptionLabel!.constrainToLeftOfSuperView(16)
        self.descriptionLabel!.constrainToRightOfSuperView(16)
        
    
        self.coffeeImageView!.constrainToLeftOfSuperView(16)
        self.coffeeImageView!.constrainToRightOfSuperView(16)
        self.addConstraints(self.coffeeImageView!.anchorToBottom(self.descriptionLabel!, padding: 8))
        self.coffeeImageView?.layer.masksToBounds = true
        self.coffeeImageView?.contentMode = .ScaleAspectFit
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[item(<=height)]",
            metrics: ["height" : 200],
            views: ["item" : self.coffeeImageView!]) as! [NSLayoutConstraint]
        self.coffeeImageView!.superview?.addConstraints(constraints)
        
        
        self.lastUpdatedLabel!.constrainToLeftOfSuperView(16)
        self.lastUpdatedLabel!.constrainToRightOfSuperView(16)
        self.addConstraints(self.lastUpdatedLabel!.anchorToBottom(self.coffeeImageView!, padding: 8))
        self.addConstraints(self.lastUpdatedLabel!.constrainHeight(21))
        self.lastUpdatedLabel!.constrainToBottomOfSuperView(8)
    }
}