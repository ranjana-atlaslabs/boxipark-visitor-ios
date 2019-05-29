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
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblEditProfile: UILabel!
    @IBOutlet weak var bottomConstrain: NSLayoutConstraint!
    
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
        btnUpload.layer.cornerRadius = 10
        btnDelete.layer.cornerRadius = 10
        
        let tap                   = UITapGestureRecognizer(target: self, action: #selector(handleLogoutTap(_:)))
        lblEditProfile.addGestureRecognizer(tap)
        lblEditProfile.isUserInteractionEnabled = true
        //lblEditProfile.set(image: #imageLiteral(resourceName: "edit_icon"), with: "Edit profile")
    }
    
    @IBAction func btnUploadBtnTap(_ sender: UIButton) {
        
        self.bottomConstrain.constant = -2000
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    @objc func handleLogoutTap(_ recognizer:UITapGestureRecognizer) {
        self.bottomConstrain.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
