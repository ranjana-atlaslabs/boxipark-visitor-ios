//
//  SignupWithCardValidation.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/18/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation


extension SignupWithLoyaltyVC {
    
    func validationInputFields() -> Bool {
        
        let card     = txtLoyaltyNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let regCode  = txtRegisterNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if card == nil || card == "" {
            
            Alert.showValidationErrorAlert(on: self, error: Constant.CARD_REQUIRED_MESSAGE_BODY)
            return false
        }
        
        if regCode == nil || regCode == "" {
            
            Alert.showValidationErrorAlert(on: self, error: Constant.REG_CARD_REQUIRED_MESSAGE_BODY)
            return false
        }
        
      
        if password == nil || password == "" {
            
            Alert.showValidationErrorAlert(on: self, error: Constant.PASSWORD_REQUIRED_MESSAGE_BODY)
            return false
        }
        
        
        if password!.count < Constant.MINIMUM_PASSWORD_CHARACHTERS {
            
            Alert.showValidationErrorAlert(on: self, error: Constant.PASSWORD_INVALID_MESSAGE_BODY)
            return false
        }
        
        return true
    }
}
