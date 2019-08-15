//
//  HistroyModel.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/23/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation
import UIKit

struct TransationResult: Decodable {
    
    var result: String!
    var transactions: [Transaction]!
    var walletInfo: [WalletInfo]!
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
    var walletCode: Int!
}

struct WalletInfo: Decodable {
    
    var name: String!
    var scale: Int!
    var walletCode: Int!
}


struct TransactionTable {
    
    var storeName: String!
    var accrued: String!
    var balance: String!
    var redeemed: String!
    var walletCode: Int!
    var datetime: String!
    var transactionId: Int!

}

struct TransactionTablePoint {
    
    var storeName: String!
    var point: String!
    var datetime: String!
    var transactionId: Int!
    var lableColor: UIColor!
}


struct TransactionTableReward {
    
    var storeName: String!
    var reward: String!
    var datetime: String!
    var transactionId: Int!
    var lableColor: UIColor!
    
}
