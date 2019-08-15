//
//  LoginValidations.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/15/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation

extension LoginVC {
    
    func validationInputFields() -> Bool {
        
        let name     = txtUsername.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if name == nil || name == "" {
            
            Alert.showValidationErrorAlert(on: self, error: Constant.EMAIL_REQUIRED_MESSAGE_BODY)
            return false
        }
        
        if password == nil || password == "" {
            
            Alert.showValidationErrorAlert(on: self, error: Constant.PASSWORD_REQUIRED_MESSAGE_BODY)
            return false
        }
        
        if !Utility.emailValidate(email: name!) {
            
            Alert.showValidationErrorAlert(on: self, error: Constant.EMAIL_INVALID_MESSAGE_BODY)
            return false
        }
        
        
        return true
    }
}
