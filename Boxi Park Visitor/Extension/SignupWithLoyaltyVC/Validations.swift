//
//  Validations.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/12/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation

extension SignupWithoutLoyaltyVC {
    
    func validationInputFields() -> Bool {
        
        let name     = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let email    = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let phone    = txtMobileNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if name == nil || name == "" {
            
            Alert.showValidationErrorAlert(on: self, error: Constant.USERNAME_REQUIRED_MESSAGE_BODY)
            return false
        }
        
        if email == nil || email == "" {
            
            Alert.showValidationErrorAlert(on: self, error: Constant.EMAIL_REQUIRED_MESSAGE_BODY)
            return false
        }
        
        if phone == nil || phone == "" {
            
            Alert.showValidationErrorAlert(on: self, error: Constant.MOBILE_REQUIRED_MESSAGE_BODY)
            return false
        }
        
        if password == nil || password == "" {
            
            Alert.showValidationErrorAlert(on: self, error: Constant.PASSWORD_REQUIRED_MESSAGE_BODY)
            return false
        }
        
        if !Utility.emailValidate(email: email!) {
            
            Alert.showValidationErrorAlert(on: self, error: Constant.EMAIL_INVALID_MESSAGE_BODY)
            return false
        }
        
        if !Utility.isValidPhone(phone: phone!) {
            
            Alert.showValidationErrorAlert(on: self, error: Constant.MOBILE_INVALID_MESSAGE_BODY)
            return false
        }
        
        return true
    }
    
}
