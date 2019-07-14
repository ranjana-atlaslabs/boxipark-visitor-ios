//
//  SignupWithLoyaltyVC.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 5/21/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import UIKit

class SignupWithLoyaltyVC: UIViewController {

    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var lblSignup: UILabel!
    
    @IBOutlet weak var txtLoyaltyNumber: UITextField!
    @IBOutlet weak var txtRegisterNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupView()  {
        btnSignup.layer.cornerRadius = 12
        
        txtLoyaltyNumber.setLeftPaddingPoints(20)
        txtRegisterNumber.setLeftPaddingPoints(20)
        txtPassword.setLeftPaddingPoints(20)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginVC.tapFunction))
        lblSignup.isUserInteractionEnabled = true
        lblSignup.addGestureRecognizer(tap)
        
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        
        self.performSegue(withIdentifier: "signWithoutLoyalty", sender: nil)
    }
 

}
