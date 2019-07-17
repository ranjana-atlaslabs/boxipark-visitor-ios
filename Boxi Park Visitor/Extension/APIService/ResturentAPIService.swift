//
//  ResturentAPIService.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/17/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation
import Alamofire

struct ResturentAPI {
    
    
    
    static func userInformation(completion: @escaping (UserInformationResult?, Error?, Int?) -> Void) {
        
        let accessToken         = AppSessionManager.getAuthToken()!
        let username            = AppSessionManager.getAuthUserName()!
        let authenticationType  = "oauth"
        
        let url = Constant.PAYTRONIX_BASE_URL + "guest/userInformation.json?merchantId=\(Constant.MERCHANT_ID)&access_token=\(accessToken)&username=\(username)&authentication=\(authenticationType)"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        let user = Constant.CLIENT_ID
        let password = Constant.SECRET
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
       
        request.setValue( "Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(request).responseJSON { response in
            switch response.result {
                
            case .success( _):
                
                do {
                    
                    let result =  try JSONDecoder().decode(UserInformationResult.self, from: response.data!)
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
