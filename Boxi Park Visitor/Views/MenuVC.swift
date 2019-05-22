//
//  MenuVC.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 5/22/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    var color = UIColor()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.setupview()
        
    }
    
    func setupview()  {
        imageView.backgroundColor = color
        imageView.image  = #imageLiteral(resourceName: "lacajitalogon")
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.cornerRadius = 10
    }
    
    @IBAction func backBtnTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
