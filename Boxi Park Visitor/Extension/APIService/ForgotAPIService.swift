//
//  ForgotAPIService.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/22/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation
import Alamofire

struct ForgotAPI {

    static func resetPassword(user: ForgotPassword,completion: @escaping (ForgotPasswordResult?, Error?, Int?) -> Void) {
    
        print(user)
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(user)
        
        let url = Constant.PAYTRONIX_BASE_URL + "guestmanagement/generateAndSendGuestResetPasswordCode.json"
 
        print(url)
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let user = Constant.CLIENT_ID
        let password = Constant.SECRET
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        request.setValue( "Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(request).responseJSON { response in
            switch response.result {
                
            case .success( _):
                
                do {
                    
                    let result =  try JSONDecoder().decode(ForgotPasswordResult.self, from: response.data!)
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

