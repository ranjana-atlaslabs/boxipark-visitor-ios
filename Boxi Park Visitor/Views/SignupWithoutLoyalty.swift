//
//  SignupWithoutLoyalty.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 5/21/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import UIKit

class SignupWithoutLoyalty: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignup: UIButton!
    
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
    

    func setupView()   {
        btnSignup.layer.cornerRadius = 10
        
        txtName.setLeftPaddingPoints(20)
        txtEmail.setLeftPaddingPoints(20)
        txtMobileNumber.setLeftPaddingPoints(20)
        txtPassword.setLeftPaddingPoints(20)
    }
    
    @IBAction func signupBtnTap(_ sender: Any) {
        self.performSegue(withIdentifier: "menu", sender: nil)
    }
}
