//
//  BottomVC.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 5/22/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import UIKit

class BottomVC: UIViewController {

    @IBOutlet weak var imgItemDetail: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var price : String!
    var itemDescription: String!
    var itemName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgItemDetail.layer.cornerRadius = 15
        lblPrice.text = price
        lblDescription.text = itemDescription
        
        imgItemDetail.image = loadImage(named: itemName)
    }
    
    
    func loadImage (named: String) -> UIImage {
        
        if let confirmedImage = UIImage(named: named) {
            return confirmedImage
        } else {
            return UIImage(named: "sampleimage")!
        }
        
    }
}
