//
//  ForgotPasswordVCValidations.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/22/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation

extension ForgotPasswordVC {
    
    func validationInputFields() -> Bool {
        
        let email     = txtEmailOrCard.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if email == nil || email == "" {
            
            Alert.showValidationErrorAlert(on: self, error: Constant.FORGOT_VC_ERROR_MESSAGE_BODY)
            return false
        }
        
        return true
    }
}
