//
//  Utility.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/12/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation

struct Utility {
    
    static func emailValidate(email: String) -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: email)
    }
    
    static func isValidPhone(phone: String) -> Bool {
        
        let phoneRegex = "^[0-9]{6,14}$"
        let valid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
        return valid
    }
    
    static func getAccessTokenUsingRefreshToken(){
        
        
        let model = LoginWithRefreshToken(authentication: "anonymous",
                                          client_id: Constant.CLIENT_ID,
                                          client_secret: Constant.SECRET,
                                          grant_type: "refresh_token",
                                          merchantId: Constant.MERCHANT_ID,
                                          scope: "user_read account_read",
                                          refresh_token: AppSessionManager.getRefreshToken()!)
        
        LoginAPI.loginWithRefreshToken(user: model) { result, error, status in
            
            
            if error == nil {
                
                if result != nil && status == 200 {
                    //save user data in userdefault
                    AppSessionManager.saveAuthToken(token: result!.access_token!)
                    AppSessionManager.saveRefreshToken(token: result!.refresh_token!)
                    
                }else {
                    getAccessTokenUsingCredential()
                }
                
            }
            
        }
    }
    
    static func getAccessTokenUsingCredential(){
        let user = LoginWithCredentials(authentication: "anonymous",
                                        client_id: Constant.CLIENT_ID,
                                        client_secret: Constant.SECRET,
                                        grant_type: "password",
                                        merchantId: Constant.MERCHANT_ID,
                                        scope: "user_read account_read",
                                        username: AppSessionManager.getAuthUserName()!,
                                        password: AppSessionManager.getAuthPassword()!)
        
        LoginAPI.loginWithCredentials(user: user) { result, error, status in
            
            if error == nil {
                
                if result != nil && status == 200 {
                    //save user data in userdefault
                    AppSessionManager.saveAuthToken(token: result!.access_token!)
                    AppSessionManager.saveRefreshToken(token: result!.refresh_token!)
                }
                
            }
            
        }
    }
}

