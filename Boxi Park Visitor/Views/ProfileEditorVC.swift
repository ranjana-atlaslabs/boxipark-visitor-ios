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
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblEditProfile: UILabel!
    @IBOutlet weak var bottomConstrain: NSLayoutConstraint!
    @IBOutlet weak var lblViewEdit: UIView!
    @IBOutlet weak var btnRestPassword: UIButton!
    
    var userInformations: UserInformationResult!
    let progressBar = ProgressHUD(text: Constant.WAIT_MESSAGE_TEXT, isDarMode: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupview()
    }
    
    //Called when the user click on the view (outside the UITextField)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    func setupview()  {
        btnSave.layer.cornerRadius = 12
        btnCancel.layer.cornerRadius = 12
        btnUpload.layer.cornerRadius = 12
        btnDelete.layer.cornerRadius = 12
        btnRestPassword.layer.cornerRadius = 12
        
        let tap                   = UITapGestureRecognizer(target: self, action: #selector(handleCancelTap(_:)))
        lblEditProfile.addGestureRecognizer(tap)
        lblEditProfile.isUserInteractionEnabled = true
        lblViewEdit.addGestureRecognizer(tap)
        lblViewEdit.isUserInteractionEnabled = true
        //lblEditProfile.set(image: #imageLiteral(resourceName: "edit_icon"), with: "Edit profile")
        
        dataBindFromApi()
        
        self.view.addSubview(progressBar)
        progressBar.hide()
    }
    
    func dataBindFromApi()  {
        
        if let username = userInformations.fields.firstName {
            txtUsername.text = username
            AppSessionManager.saveAuthFirstName(userName: username)
        }
        
        if let email = userInformations.fields.email {
            txtEmail.text = email
        }
        
        if let mobile = userInformations.fields.mobilePhone {
            txtMobileNumber.text = mobile
        }
        
    }
    
    @IBAction func restBtnTap(_ sender: UIButton) {
        
        let email     = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let user      = ForgotPassword(authentication: Constant.ANONYMOUS_AUTH_TYPE, merchantId: Constant.MERCHANT_ID, username: email!)
        
        self.progressBar.show()
        
        ForgotAPI.resetPassword(user: user) { result, error, status in
            
            self.progressBar.hide()
            if  status == 200 && result != nil {
                
                if result?.result == Constant.PAYTRONIX_API_SUCCESS_RESULT {
                    
                    let components = email?.components(separatedBy: "@")
                    let result = Utility.hideMidChars((components?.first!)!) + "@" + (components?.last!)!
                    Alert.showForgetPasswordRequestSuccessAlert(on: self, isHideController: false, email: result)
                    
                }else {
                    Alert.showValidationErrorAlert(on: self, error: result?.errorMessage ?? "Request unavailable")
                }
            }else{
                Alert.showValidationErrorAlert(on: self, error: result?.errorMessage ?? "Request unavailable")
            }
            
        }
        
    }
    
    @IBAction func saveBtnTap(_ sender: Any) {
        
        if validationInputFields() {
            
            let name     = txtUsername.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let phone    = txtMobileNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let userFields = EditUserFields(style: "typed", firstName: [name!], mobilePhone: [phone!])
            let accountFields = AccoutnFields(style: "typed")
            
            let accessToken         = AppSessionManager.getAuthToken()!
            let printedCardNumber   = AppSessionManager.getPrintedCardNumber()!

            let user = ProfileEdit(authentication: "oauth", client_id: Constant.CLIENT_ID, client_secret: Constant.SECRET, merchantId: Constant.MERCHANT_ID, access_token: accessToken, printedCardNumber: printedCardNumber, enforceUniqueFields: ["username", "email"], setUserFields: userFields, setAccountFields: accountFields)
            

            self.progressBar.show()
            
            ProfileAPI.updateUser(user: user) { result , error, status in
                
                self.progressBar.hide()
                
                if status == 200 && result != nil {
                    
                    if result?.result == Constant.PAYTRONIX_API_SUCCESS_RESULT {
                        Alert.showUpdateSucessAlert(on: self)
                        
                    }else if (result?.errorsByField?["setUserFields/mobilePhone"]) != nil  {
                        
                        self.dataBindFromApi()
                        //Show error msg mobilePhone invalid
                        Alert.showValidationErrorAlert(on: self, error: Constant.INVALID_PHONE_NUMBER_MESSAGE_BODY)
                    }
                    else {
                        Alert.showFailReuqestAlert(on: self)   
                    }
                    
                }else if status == 401 {
                    
                    Utility.getAccessTokenUsingRefreshToken()
                    
                }else if error != nil {
                    
                    //Server error
                    _ = APIErrorHandling(error: error!, vc: self)
                    
                }
            }
            
        }
        
    }
    
    
    @IBAction func cancelBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnUploadBtnTap(_ sender: UIButton) {
        
        self.bottomConstrain.constant = -2000
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    @objc func handleCancelTap(_ recognizer:UITapGestureRecognizer) {
        self.bottomConstrain.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
