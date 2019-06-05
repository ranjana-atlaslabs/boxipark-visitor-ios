//
//  Menu.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 6/3/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation
import UIKit

struct MenuData: Decodable {
    
    var code: Int!
    var data: MData!
    
}

struct MData: Decodable {
    var menus: [Restaurant]!
    var photos: [String]!
}

struct Restaurant: Decodable{
    
    var id: Int!
    var name: String!
    var updated: String!
    var menu_type: String!
    var sections: [Section]!
    var currency: String!
    
}

struct Section: Decodable {
    
    var id: Int!
    var order_num : Int!
    var description: String!
    var name: String!
    var items: [Item]!
    
}

struct Item: Decodable {
    
    var id: Int!
    var name: String!
    var description: String!
    var choices: [Choices]!
    var photos: [String]!
    
}

struct Choices: Decodable {
    
    var order_num: Int!
    var name: String!
    var unit: String!
    var prices: Price!
}

struct Price: Decodable {
    var max: QuantumValue!
    var min: QuantumValue!
}



enum QuantumValue: Decodable {
    
    case int(Int), string(String), double(Double)
    
    init(from decoder: Decoder) throws {
        
        if let double = try? decoder.singleValueContainer().decode(Double.self) {
            self = .double(double)
            return
        }
        
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }
        
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }

        throw QuantumError.missingValue
    }
    
    enum QuantumError:Error {
        case missingValue
    }
}


class ResturentLocalData {
    
    var id  : Int!
    var name: String!
    var logo: UIImage!
    var color: UIColor!
    
    init(id: Int, name: String, logo: UIImage, color: UIColor) {
        self.id = id
        self.name = name
        self.logo = logo
        self.color = color
    }
}
