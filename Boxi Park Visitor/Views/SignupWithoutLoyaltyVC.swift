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
    
    let progressBar = ProgressHUD(text: Constant.WAIT_MESSAGE_TEXT, isDarMode: false)
    var isCardUser  = false
    var regNumber   = String()
    var cardNumber  = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    //Called when the user click on the view (outside the UITextField)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func setupView()   {
        
        getEnrollmentConfig()
        
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
    
    @IBAction func backBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signupBtnTap(_ sender: Any) {
        
        //Validate user inputs
        if validationInputFields() {
            
            let email    = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let name     = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let mobile   = txtMobileNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let userFields = UserFields(style: "typed", username: [email!], password: [password!], firstName: [name!], email: [email!], mobilePhone: [mobile!])
            let accountFields = AccoutnFields(style: "typed")
            
            if isCardUser {
                
                let user = RegisterWithCard(authentication: "card", client_id: Constant.CLIENT_ID, client_secret: Constant.SECRET, merchantId: Constant.MERCHANT_ID, printedCardNumber: self.cardNumber, registrationCode: self.regNumber, enforceUniqueFields: ["username", "email"], setUserFields: userFields, setAccountFields: accountFields)
                
                
                progressBar.show()
                
                //Make api call
                registerUser(user: user)
                
            }else {
                //create user object
                
                
                let user = CreateAndRegister(authentication: Constant.ANONYMOUS_AUTH_TYPE, client_id: Constant.CLIENT_ID, client_secret: Constant.SECRET, merchantId: Constant.MERCHANT_ID, cardTemplateCode: Constant.CARD_TEMPLATE_CODE, activationStoreCode: Constant.SOTRE_CODE, enforceUniqueFields: ["username", "email"], setUserFields: userFields, setAccountFields: accountFields)
                
                progressBar.show()
                
                //Make api call
                createUser(createUser: user)
            }
            
        }
    }
    
    func createUser(createUser: CreateAndRegister)  {
        
        SignupWithoutLoyaltyAPI.createAndRegisterUser(user: createUser) { result, error, status in
            
            self.progressBar.hide()
            if error == nil {
                
                if result?.result == Constant.PAYTRONIX_API_CARD_CREATED_SUCCESS_RESULT {
                    
                    if result?.oauthTokens != nil {
                        //save user data in userdefault
                        AppSessionManager.saveAuthToken(token: result!.oauthTokens!.access_token!)
                        AppSessionManager.saveRefreshToken(token: result!.oauthTokens!.refresh_token!)
                        AppSessionManager.savePrintedCardNumber(number: result!.printedCardNumber!)
                        AppSessionManager.saveAuthUserName(userName: createUser.setUserFields!.username[0])
                        AppSessionManager.saveAuthPassword(password: createUser.setUserFields!.password[0])
                        self.performSegue(withIdentifier: "menu", sender: nil)
                    }
                    
                    
                    
                }else if result?.result == Constant.PAYTRONIX_API_USER_EXISTS_RESULT {
                    
                    //Show error msg user all ready exsits
                    Alert.showValidationErrorAlert(on: self, error: Constant.USER_ALLREADY_EXSITS_MESSAGE_BODY)
                    
                }
                else {
                    
                    if (result?.errorsByField?["setUserFields/username"]) != nil  {
                        
                        //Show error msg user all ready exsits
                        Alert.showValidationErrorAlert(on: self, error: Constant.USER_ALLREADY_EXSITS_MESSAGE_BODY)
                        
                    }else if (result?.errorsByField?["setUserFields/password"]) != nil  {
                        //Show error msg password invalid
                        Alert.showValidationErrorAlert(on: self, error: Constant.PASSWORD_INVALID_MESSAGE_BODY)
                        
                    }else if (result?.errorsByField?["setUserFields/mobilePhone"]) != nil  {
                        //Show error msg mobilePhone invalid
                        Alert.showValidationErrorAlert(on: self, error: Constant.INVALID_PHONE_NUMBER_MESSAGE_BODY)
                        
                    }else if result?.errorMessage != nil {
                        Alert.showValidationErrorAlert(on: self, error: (result?.errorMessage)!)
                    }
                    else {
                        Alert.showValidationErrorAlert(on: self, error: Constant.FAILD_REUQEST_ERROR_MESSAGE_BODY)
                    }
                }
                
                
            }else {
                //Server error
                _ = APIErrorHandling(error: error!, vc: self)
            }
            
        }
    }
    
    func registerUser(user: RegisterWithCard)  {
        
        SignupWithLoyaltyAPI.registerUser(user: user){ result, error, status in
            
            self.progressBar.hide()
            if error == nil {
                
                if result?.result == Constant.PAYTRONIX_API_SUCCESS_RESULT {
                    
                    if result?.oauthTokens != nil {
                        //save user data in userdefault
                        AppSessionManager.saveAuthToken(token: result!.oauthTokens!.access_token!)
                        AppSessionManager.saveRefreshToken(token: result!.oauthTokens!.refresh_token!)
                        AppSessionManager.savePrintedCardNumber(number: (result!.oauthTokens?.printedCardNumber!)!)
                        AppSessionManager.saveAuthUserName(userName: user.setUserFields!.username[0])
                        AppSessionManager.saveAuthPassword(password: user.setUserFields!.password[0])
                        self.performSegue(withIdentifier: "menu", sender: nil)
                    }
                    
                    
                    
                }else if result?.result == Constant.PAYTRONIX_API_USER_EXISTS_RESULT {
                    
                    //Show error msg user all ready exsits
                    Alert.showValidationErrorAlert(on: self, error: Constant.USER_ALLREADY_EXSITS_MESSAGE_BODY)
                    
                }
                else {
                    
                    if (result?.errorsByField?["setUserFields/username"]) != nil  {
                        
                        //Show error msg user all ready exsits
                        Alert.showValidationErrorAlert(on: self, error: Constant.USER_ALLREADY_EXSITS_MESSAGE_BODY)
                        
                    }else if (result?.errorsByField?["setUserFields/password"]) != nil  {
                        //Show error msg password invalid
                        Alert.showValidationErrorAlert(on: self, error: Constant.PASSWORD_INVALID_MESSAGE_BODY)
                    }else if (result?.errorsByField?["setUserFields/mobilePhone"]) != nil  {
                        //Show error msg mobilePhone invalid
                        Alert.showValidationErrorAlert(on: self, error: Constant.INVALID_PHONE_NUMBER_MESSAGE_BODY)
                        
                    }else if result?.errorMessage != nil {
                        Alert.showValidationErrorAlert(on: self, error: (result?.errorMessage)!)
                    }
                    else {
                        Alert.showValidationErrorAlert(on: self, error: Constant.FAILD_REUQEST_ERROR_MESSAGE_BODY)
                    }
                }
                
                
            }else {
                //Server error
                _ = APIErrorHandling(error: error!, vc: self)
            }
            
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
    
    //MARK: Keybaord handling
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
