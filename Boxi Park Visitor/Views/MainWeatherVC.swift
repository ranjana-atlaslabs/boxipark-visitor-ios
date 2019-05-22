//
//  MainWeatherVC.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 5/21/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import UIKit

class MainWeatherVC: UIViewController {

    @IBOutlet weak var btnStart: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
    }
    
    func setupView()  {
        btnStart.layer.cornerRadius = 10
    }
    
    
}
