//
//  SignupWithoutLoyalty.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 5/21/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import UIKit

class SignupWithoutLoyaltyVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignup: UIButton!
    
    let progressBar = ProgressHUD(text: Constant.WAIT_MESSAGE_TEXT)
    
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
        btnSignup.layer.cornerRadius = 12
        
        txtName.setLeftPaddingPoints(20)
        txtEmail.setLeftPaddingPoints(20)
        txtMobileNumber.setLeftPaddingPoints(20)
        txtPassword.setLeftPaddingPoints(20)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        self.view.addSubview(progressBar)
        progressBar.hide()
    }
    
    @IBAction func signupBtnTap(_ sender: Any) {
        
        if validationInputFields() {
            
            let userFields = UserFields(style: "typed", username: [txtEmail.text!], password: [txtPassword.text!])
            let accountFields = AccoutnFields(style: "typed")
            
            let user = CreateAndRegister(authentication: "anonymous", client_id: Constant.CLIENT_ID, client_secret: Constant.SECRET, merchantId: Constant.MERCHANT_ID, cardTemplateCode: Constant.CARD_TEMPLATE_CODE, activationStoreCode: Constant.SOTRE_CODE, enforceUniqueFields: ["username"], setUserFields: userFields, setAccountFields: accountFields)
            
            progressBar.show()
            createUser(createUser: user)
        }
        //self.performSegue(withIdentifier: "menu", sender: nil)
    }
    
    func createUser(createUser: CreateAndRegister)  {
        
        SignupWithoutLoyaltyAPI.createAndRegisterUser(user: createUser) { result, error, status in
            
            self.progressBar.hide()
            if error == nil {
                
                
                
            }else {
                _ = APIErrorHandling(error: error!, vc: self)
            }
            
            
        }
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height - 150)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
