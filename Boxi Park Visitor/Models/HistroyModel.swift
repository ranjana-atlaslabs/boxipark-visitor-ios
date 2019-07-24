//
//  HistroyModel.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/23/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation

struct TransationResult: Decodable {
    
    var result: String!
    var transactions: [Transaction]!
}

struct Transaction: Decodable {
    
    var datetime: String!
    var details: [Detail]!
    var storeName: String!
    var transactionId: Int!
    
}

struct Detail: Decodable {
    
    var accrued: String!
    var balance: String!
    var redeemed: String!
    var walletCode: String!
}


struct TransactionTable {
    
    var storeName: String!
    var accrued: String!
    var balance: String!
    var redeemed: String!
    var walletCode: String!
    var datetime: String!
    var transactionId: Int!

}
