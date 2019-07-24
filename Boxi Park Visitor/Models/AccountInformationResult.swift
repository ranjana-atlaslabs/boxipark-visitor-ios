//
//  AccountInformationResult.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/23/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation

struct AccountInformationResult: Decodable {
    
    var result: String!
    var pointBalances: [PointBalances]!
}

struct PointBalances: Decodable  {
    
    var balance: String!
    
}
