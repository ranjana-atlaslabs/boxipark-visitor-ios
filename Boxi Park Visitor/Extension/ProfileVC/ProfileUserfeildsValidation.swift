//
//  ProfileUserfeildsValidation.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/24/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation

extension ProfileEditorVC {
    
    func validationInputFields() -> Bool {
        
        let name      = txtUsername.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let phone     = txtMobileNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        
        if name == nil || name == "" {
            
            Alert.showValidationErrorAlert(on: self, error: Constant.FULL_NAME_REQUIRED_MESSAGE_BODY)
            return false
        }
        
        if phone == nil || phone == "" {
            
            Alert.showValidationErrorAlert(on: self, error: Constant.MOBILE_EMPTY_MESSAGE_BODY)
            return false
        }
        
        if !Utility.isValidPhone(phone: phone!) {
            
            Alert.showValidationErrorAlert(on: self, error: Constant.MOBILE_INVALID_MESSAGE_BODY)
            return false
        }
        
        return true
    }
    
}
