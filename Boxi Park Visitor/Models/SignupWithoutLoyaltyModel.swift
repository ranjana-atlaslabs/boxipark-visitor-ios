//
//  SignupWithoutLoyaltyVC.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/12/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation
import UIKit

struct CreateAndRegister: Codable {
    
    var authentication: String!
    var client_id: String!
    var client_secret: String!
    var merchantId: Int!
    var cardTemplateCode: Int!
    var activationStoreCode: String!
    var enforceUniqueFields: [String]!
    var setUserFields: UserFields!
    var setAccountFields: AccoutnFields!
}

struct UserFields: Codable {
    
    var style: String!
    var username: [String]!
    var password: [String]!
    
}

struct AccoutnFields: Codable {
    var style: String!
}

struct CreateAndRegisterResult: Codable {
    
    var result: String!
    var accountId: Int?
    var oauthTokens: OauthToken?
    var printedCardNumber: String?
}

struct OauthToken: Codable {
    
    var access_token: String!
    var expires_in: Int!
    var printedCardNumber: String!
    var refresh_token: String!
}

struct EnrollmentConfig: Decodable {
    
    var result: String!
    var config: Config!
}

struct Config: Decodable {
    var fields: [Fields]!
}

struct Fields: Decodable {
    
    var type: String!
    var field: String!
    var minLength: String!
}
