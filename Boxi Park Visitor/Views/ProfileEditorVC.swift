//
//  ProfileEditor.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 5/23/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import UIKit

class ProfileEditorVC: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupview()
       
    }
    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupview()  {
        btnSave.layer.cornerRadius = 10
        btnCancel.layer.cornerRadius = 10
    }
}
