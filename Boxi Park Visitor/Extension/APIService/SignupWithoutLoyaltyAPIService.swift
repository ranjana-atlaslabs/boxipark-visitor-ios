//
//  SignupWithoutLoyaltyAPIService.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/12/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation
import Alamofire

struct SignupWithoutLoyaltyAPI {
    
    static func createAndRegisterUser(user: CreateAndRegister ,completion: @escaping (CreateAndRegisterResult?, Error?, Int?) -> Void) {
        
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(user)
        
        let url = Constant.PAYTRONIX_BASE_URL + "enrollment/createAndRegister.json"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        Alamofire.request(request).responseJSON { response in
            switch response.result {
                
            case .success( _):
                
                do {
                    let result =  try JSONDecoder().decode(CreateAndRegisterResult.self, from: response.data!)
                    completion(result, nil, response.response?.statusCode)
                }
                catch let err {
                    print(err)
                    completion(nil, err, response.response?.statusCode)
                }
                
            case .failure(let error):
                completion(nil, error, response.response?.statusCode)
            }
        }
    }
    
    static func enrollmentConfig(completion: @escaping (EnrollmentConfig?, Error?, Int?) -> Void) {
        
        let url = Constant.PAYTRONIX_BASE_URL + "enrollment/enrollmentConfig.json?merchantId=\(Constant.MERCHANT_ID)&cardTemplateCode=\(Constant.CARD_TEMPLATE_CODE)"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        Alamofire.request(request).responseJSON { response in
            switch response.result {
                
            case .success( _):
                
                do {
                    let result =  try JSONDecoder().decode(EnrollmentConfig.self, from: response.data!)
                    completion(result, nil, response.response?.statusCode)
                }
                    
                catch let err {
                    completion(nil, err, response.response?.statusCode)
                }
                
            case .failure(let error):
                completion(nil, error, response.response?.statusCode)
            }
        }
    }
    
}
