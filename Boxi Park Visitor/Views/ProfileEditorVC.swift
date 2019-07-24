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
                    
                    Alert.showForgetPasswordRequestSuccessAlert(on: self, isHideController: false)
                    
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
            
            let userFields = UserFields(style: "typed", username: [txtEmail.text!], password: [AppSessionManager.getAuthPassword()!], firstName: [name!], email: [txtEmail.text!], mobilePhone: [phone!])
            let accountFields = AccoutnFields(style: "typed")
            
            let user = ProfileEdit(authentication: "card", client_id: Constant.CLIENT_ID, client_secret: Constant.SECRET, merchantId: Constant.MERCHANT_ID, accountId: userInformations.accountIds[0], enforceUniqueFields: ["username", "email"], setUserFields: userFields, setAccountFields: accountFields)
            

            self.progressBar.show()
            
            ProfileAPI.updateUser(user: user) { result , error, status in
                
                self.progressBar.hide()
                
                if status == 200 && result != nil {
                    
                    if result?.result == Constant.PAYTRONIX_API_CARD_CREATED_SUCCESS_RESULT {
                        Alert.showUpdateSucessAlert(on: self)
                    }else {
                        Alert.showFailReuqestAlert(on: self)   
                    }
                    
                }else if status == 403 {
                    
                    Utility.getAccessTokenUsingRefreshToken()
                    
                }else if error != nil {
                    
                    //Server error
                    _ = APIErrorHandling(error: error!, vc: self)
                    
                }
            }
            
        }
        
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
