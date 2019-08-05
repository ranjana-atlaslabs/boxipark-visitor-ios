//
//  RegisterWithCard.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/18/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation


struct RegisterWithCard: Codable {
    
    var authentication: String!
    var client_id: String!
    var client_secret: String!
    var merchantId: Int!
    var printedCardNumber: String!
    var registrationCode: String!
    var enforceUniqueFields: [String]!
    var setUserFields: UserFields!
    var setAccountFields: AccoutnFields!
}

struct ValidateCard: Decodable {
    
    var result: String!
    var registrationStatus: String?
    var primaryCard: PrimaryCard?
}

struct PrimaryCard: Decodable {
    
    var status: String
}
