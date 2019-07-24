//
//  ProfileEditModel.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/24/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation


struct ProfileEdit: Codable {
    
    var authentication: String!
    var client_id: String!
    var client_secret: String!
    var merchantId: Int!
    var accountId: Int!
    var enforceUniqueFields: [String]!
    var setUserFields: UserFields!
    var setAccountFields: AccoutnFields!
}
