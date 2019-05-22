//
//  MenuItem.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 5/22/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import UIKit

class MenuItem: UITableViewCell {

    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
