//
//  HistroyAPIService.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/23/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation
import Alamofire

struct HistroyAPI {
    
    static func getTransactionHistroy(completion: @escaping (TransationResult?, Error?, Int?) -> Void) {
        
        let accessToken         = AppSessionManager.getAuthToken()!
        let username            = AppSessionManager.getAuthUserName()!
        let printedCardNumber   = AppSessionManager.getPrintedCardNumber()!
        let authenticationType  = "oauth"
        
        let url = Constant.PAYTRONIX_BASE_URL + "guest/transactionHistory.json?merchantId=\(Constant.MERCHANT_ID)&access_token=\(accessToken)&username=\(username)&authentication=\(authenticationType)&printedCardNumber=\(printedCardNumber)"
        
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
                    
                    let result =  try JSONDecoder().decode(TransationResult.self, from: response.data!)
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
    
}
