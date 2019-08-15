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
    var rewardBalances: [RewardBalances]!
}

struct PointBalances: Decodable  {
    
    var balance: String!
    
}


struct RewardBalances: Decodable  {
    
    var balance: String!
    var expirations: [Expirations]?
    var name: String!
}

struct Expirations: Decodable  {
    
    var amount: String!
    var expirationDate: String!
   
   
}

