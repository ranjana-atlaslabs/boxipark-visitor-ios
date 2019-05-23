//
//  OfferVC.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 5/23/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import UIKit

class OfferVC: UIViewController {

    @IBOutlet weak var imgWeather: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupview()
    }
    
    func setupview()  {
        // 1. request an UITraitCollection instance
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        
        // 2. check the idiom
        switch (deviceIdiom) {
            
        case .pad:
            imgWeather.contentMode = .right
        case .phone:
            imgWeather.contentMode = .scaleAspectFit
        case .tv:
            print("tvOS style UI")
        default:
            print("Unspecified UI idiom")
        }
    }

    @IBAction func backBtnTap(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

}
