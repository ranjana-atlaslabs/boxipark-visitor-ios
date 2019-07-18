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
    
    func setupView()  {
        
        getEnrollmentConfig()
        
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
 
    @IBAction func signBtnTap(_ sender: UIButton) {
        
        //Validate user inputs
        if validationInputFields() {
            
            let email    = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let name     = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let mobile   = txtMobileNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create user object
            let userFields = UserFields(style: "typed", username: [email!], password: [password!], firstName: [name!], email: [email!], mobilePhone: [mobile!])
            let accountFields = AccoutnFields(style: "typed")
            
            let user = CreateAndRegister(authentication: "anonymous", client_id: Constant.CLIENT_ID, client_secret: Constant.SECRET, merchantId: Constant.MERCHANT_ID, cardTemplateCode: Constant.CARD_TEMPLATE_CODE, activationStoreCode: Constant.SOTRE_CODE, enforceUniqueFields: ["username", "email"], setUserFields: userFields, setAccountFields: accountFields)
            
            progressBar.show()
            
            //Make api call
            //createUser(createUser: user)
        }
        
    }
    
    func getEnrollmentConfig()  {
        
        SignupWithoutLoyaltyAPI.enrollmentConfig(){ result, error, status in
            
            if error == nil {
                
                if result?.result == Constant.PAYTRONIX_API_SUCCESS_RESULT{
                    
                    if result?.config.fields != nil && result?.config.fields.count ?? 0 > 0 {
                        
                        if let obj = result?.config.fields.enumerated().first(where: {$0.element.field == "password"}) {
                            //Save password min length in constant file
                            Constant.MINIMUM_PASSWORD_CHARACHTERS = obj.element.minLength
                        }
                    }
                    
                }else {
                    print(result?.result! ?? "")
                }
                
            }else{
                print("Error in Enrollment config")
            }
            
        }
    }
}
