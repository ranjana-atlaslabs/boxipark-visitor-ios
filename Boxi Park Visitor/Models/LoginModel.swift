//
//  LoginModel.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/15/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation

struct LoginWithCredentials: Codable {
    
    var authentication: String!
    var client_id: String!
    var client_secret: String!
    var grant_type: String!
    var merchantId: Int!
    var scope: String!
    var username: String!
    var password: String!
    
}

struct LoginWithRefreshToken: Codable {
    
    var authentication: String!
    var client_id: String!
    var client_secret: String!
    var grant_type: String!
    var merchantId: Int!
    var scope: String!
    var refresh_token: String!    
}

struct LoginResult: Decodable {
    
    var access_token: String!
    var expires_in: Int!
    var refresh_token: String!
    var scope: String!
    var token_type: String!
    var username: String!
    var result: String!
}

