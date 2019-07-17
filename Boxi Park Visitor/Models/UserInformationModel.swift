//
//  UserInformationModel.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/17/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation

struct UserInformationResult: Decodable {
    
    var result: String!
    var accountIds: [Int]!
    var addresses: [Address]!
    var fields: UserInformationFields!
    var primaryCardNumbers: [String]!
}

struct Address: Decodable{
    var addressId: Int!
    var label: String!
}

struct UserInformationFields: Decodable {
    
    var addressLabel: String!
    var emailVerified: Bool!
    var username: String!
    var firstName: String!
    var email: String!
    var mobilePhone: String!
}
