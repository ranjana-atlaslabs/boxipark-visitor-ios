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
    
    let progressBar = ProgressHUD(text: Constant.WAIT_MESSAGE_TEXT, isDarMode: false)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //Called when the user click on the view (outside the UITextField).
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
  
    func setupView()  {
        
        btnLogin.layer.cornerRadius = 12
        txtUsername.setLeftPaddingPoints(20)
        txtPassword.setLeftPaddingPoints(20)
        
        var tap = UITapGestureRecognizer(target: self, action: #selector(LoginVC.signUpLblTapFunction))
        lblSignUp.isUserInteractionEnabled = true
        lblSignUp.addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(LoginVC.forgetLblTapFunction))
        lblForgotPassword.isUserInteractionEnabled = true
        lblForgotPassword.addGestureRecognizer(tap)
        
        self.view.addSubview(progressBar)
        progressBar.hide()
    }
 
    
    @IBAction func loginBtnTap(_ sender: UIButton) {
        loginUsingPassword()
    }
    
    @objc func signUpLblTapFunction(sender:UITapGestureRecognizer) {
        
        self.performSegue(withIdentifier: "signup", sender: nil)
    }
    
    @objc func forgetLblTapFunction(sender:UITapGestureRecognizer) {
        
        self.performSegue(withIdentifier: "forgot", sender: nil)
    }
    
    func loginUsingPassword()  {
        
        progressBar.show()
        if validationInputFields() {
            
            let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let name     = txtUsername.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let user = LoginWithCredentials(authentication: Constant.ANONYMOUS_AUTH_TYPE,
                                            client_id: Constant.CLIENT_ID,
                                            client_secret: Constant.SECRET,
                                            grant_type: "password",
                                            merchantId: Constant.MERCHANT_ID,
                                            scope: "user_read account_read",
                                            username: name!,
                                            password: password!)
            
            LoginAPI.loginWithCredentials(user: user) { result, error, status in
            
                self.progressBar.hide()
                if error == nil {
                    
                    if result != nil && status == 200 {
                        //save user data in userdefault
                        AppSessionManager.saveAuthToken(token: result!.access_token!)
                        AppSessionManager.saveRefreshToken(token: result!.refresh_token!)
                        AppSessionManager.saveAuthUserName(userName: name!)
                        AppSessionManager.saveAuthPassword(password: password!)
                        self.performSegue(withIdentifier: "menu", sender: nil)
                    }else {
                        Alert.showInvalidUserNameAlert(on: self)
                    }
                    
                }else {
                    //Server error
                    _ = APIErrorHandling(error: error!, vc: self)
                }
                
            }
        }else{
            self.progressBar.hide()
        }
    }
}
