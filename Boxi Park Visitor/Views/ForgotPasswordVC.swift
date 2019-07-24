//
//  ForgotPasswordVC.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/22/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    
    @IBOutlet weak var txtEmailOrCard: UITextField!
    @IBOutlet weak var btnForgot: UIButton!
    
    let progressBar = ProgressHUD(text: Constant.VALIDATING_MESSAGE_TEXT, isDarMode: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    
    //Called when the user click on the view (outside the UITextField).
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupView()  {
        
        btnForgot.layer.cornerRadius = 12
        txtEmailOrCard.setLeftPaddingPoints(20)
        
        self.view.addSubview(progressBar)
        progressBar.hide()
    }
    
    @IBAction func backBtnTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func forgotBtnTap(_ sender: UIButton) {
        
        if validationInputFields() {
            
            progressBar.show()
            
            let email     = txtEmailOrCard.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let user      = ForgotPassword(authentication: Constant.ANONYMOUS_AUTH_TYPE, merchantId: Constant.MERCHANT_ID, username: email!)
            
            ForgotAPI.resetPassword(user: user) { result, error, status in
                
                self.progressBar.hide()
                
                if  status == 200 && result != nil {
                    
                    if result?.result == Constant.PAYTRONIX_API_SUCCESS_RESULT {
                        
                        
                    }else {
                        Alert.showValidationErrorAlert(on: self, error: result?.errorMessage ?? "Request unavailable")
                    }
                }else{
                    Alert.showValidationErrorAlert(on: self, error: result?.errorMessage ?? "Request unavailable")
                }
                
            }
            
        }
    }
}
