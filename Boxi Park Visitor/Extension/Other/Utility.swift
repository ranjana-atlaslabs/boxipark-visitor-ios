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
}

