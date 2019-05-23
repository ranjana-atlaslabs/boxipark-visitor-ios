//
//  MapVC.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 5/23/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import UIKit
import WebKit

class MapVC: UIViewController {

    @IBOutlet weak var webViewMap: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            webViewMap.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        
    }
    
    @IBAction func backBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
