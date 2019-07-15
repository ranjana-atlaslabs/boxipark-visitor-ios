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
    
    @IBAction func getStartBtnTap(_ sender: UIButton) {
        
        if AppSessionManager.getAuthUserName() == nil {
            self.performSegue(withIdentifier: "login", sender: nil)
        }else {
            loginUsingPassword()
        }
    }
    
    
    func loginUsingPassword()  {
        
       
            let user = LoginWithCredentials(authentication: "anonymous",
                                            client_id: Constant.CLIENT_ID,
                                            client_secret: Constant.SECRET,
                                            grant_type: "password",
                                            merchantId: Constant.MERCHANT_ID,
                                            scope: "user_read account_read",
                                            username: AppSessionManager.getAuthUserName()!,
                                            password: AppSessionManager.getAuthPassword()!)
            
            LoginAPI.loginWithCredentials(user: user) { result, error, status in
                
                if error == nil {
                    
                    if result != nil && status == 200 {
                        //save user data in userdefault
                        AppSessionManager.saveAuthToken(token: result!.access_token!)
                        AppSessionManager.saveRefreshToken(token: result!.refresh_token!)
                        self.performSegue(withIdentifier: "main_menu", sender: nil)
                    }else {
                        Alert.showInvalidUserNameAlert(on: self)
                    }
                    
                }else {
                    //Server error
                    _ = APIErrorHandling(error: error!, vc: self)
                }
                
            }
    }
}
