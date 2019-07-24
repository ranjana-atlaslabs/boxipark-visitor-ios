//
//  ForgotPasswordModel.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/22/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation

struct ForgotPassword: Codable {
    
    var authentication: String!
    var merchantId: Int!
    var username: String!
    
}

struct ForgotPasswordResult: Decodable {
    
    var result: String!
    var errorMessage: String?
}
