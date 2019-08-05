//
//  Utility.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/12/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation
import UIKit

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
        
        
        let model = LoginWithRefreshToken(authentication: Constant.ANONYMOUS_AUTH_TYPE,
                                          client_id: Constant.CLIENT_ID,
                                          client_secret: Constant.SECRET,
                                          grant_type: "refresh_token",
                                          merchantId: Constant.MERCHANT_ID,
                                          scope: "user_read user_write account_read account_write",
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
        let user = LoginWithCredentials(authentication: Constant.ANONYMOUS_AUTH_TYPE,
                                        client_id: Constant.CLIENT_ID,
                                        client_secret: Constant.SECRET,
                                        grant_type: "password",
                                        merchantId: Constant.MERCHANT_ID,
                                        scope: "user_read user_write account_read account_write",
                                        username: AppSessionManager.getAuthUserName()!,
                                        password: AppSessionManager.getAuthPassword()!)
        
        LoginAPI.loginWithCredentials(user: user) { result, error, status in
            
            if error == nil {
                
                if result != nil && status == 200 {
                    //save user data in userdefault
                    AppSessionManager.saveAuthToken(token: result!.access_token!)
                    AppSessionManager.saveRefreshToken(token: result!.refresh_token!)
                }else {
                    AppSessionManager.removeAllObject()
                }
                
            }
            
        }
    }
    
    static func stringToDate(date: String, formaterType: String) -> Date {
        
        let formater = DateFormatter()
        formater.dateFormat = formaterType
        
        
        let date = formater.date(from: date)
        
        return date ?? Date()
        
    }
    
    static func dateToString(date: Date, formaterType: String) -> String {
        
        let formater = DateFormatter()
        formater.dateFormat = formaterType
        
        
        let date = formater.string(from: date)
        
        return date
        
    }
    
    static func hideMidChars(_ value: String) -> String {
        
        var maskStr = ""
        value.forEach { (char) in
            maskStr += "*"
            
        }
        
        return maskStr
    }
}

extension UILabel {
    func set(image: UIImage, with text: String) {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        let attachmentStr = NSAttributedString(attachment: attachment)
        
        let mutableAttributedString = NSMutableAttributedString()
        
        let textString = NSAttributedString(string: text + "  ", attributes: [.font: self.font!])
        mutableAttributedString.append(textString)
        
        
        mutableAttributedString.append(attachmentStr)
        
        self.attributedText = mutableAttributedString
    }
    
    func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment
        
        let attrString = NSMutableAttributedString()
        if (self.attributedText != nil) {
            attrString.append( self.attributedText!)
        } else {
            attrString.append( NSMutableAttributedString(string: self.text!))
            attrString.addAttribute(NSAttributedString.Key.font, value: self.font ?? UIFont(name: "Gotham-Bold", size: 16)! , range: NSMakeRange(0, attrString.length))
        }
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
    
  
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
