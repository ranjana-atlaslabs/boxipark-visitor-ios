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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgItemDetail.layer.cornerRadius = 15
    }
}
