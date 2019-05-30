//
//  LoginVC.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 5/21/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblForgotPassword: UILabel!
    @IBOutlet weak var lblSignUp: UILabel!
    
    
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
        
        btnLogin.layer.cornerRadius = 12
        txtUsername.setLeftPaddingPoints(20)
        txtPassword.setLeftPaddingPoints(20)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginVC.tapFunction))
        lblSignUp.isUserInteractionEnabled = true
        lblSignUp.addGestureRecognizer(tap)
    }
 
    
    @IBAction func loginBtnTap(_ sender: UIButton) {
        self.performSegue(withIdentifier: "menu", sender: nil)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        
        self.performSegue(withIdentifier: "signup", sender: nil)
    }
    
}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
