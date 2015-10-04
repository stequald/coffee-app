//
//  CoffeeNameTableViewCell.swift
//  Coffee App
//
//  Created by Tim Lee on 10/3/15.
//  Copyright © 2015 Tim Lee. All rights reserved.
//

import Foundation

class CoffeeNameTableViewCell:UITableViewCell {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var nameLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        self.nameLabel = UILabel()
        self.nameLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel?.textColor = UIColor(netHex: 0x666666)
        self.nameLabel?.font = UIFont(name: self.nameLabel!.font.fontName, size: 26)
        self.addSubview(self.nameLabel!)

        self.nameLabel!.constrainToLeftOfSuperView(16)
        self.nameLabel!.constrainToRightOfSuperView(16)
        self.nameLabel!.constrainToTopOfSuperView(16)
        self.nameLabel!.constrainToBottomOfSuperView(16)
    }
}