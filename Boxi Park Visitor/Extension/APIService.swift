//
//  APIService.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 6/3/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation
import Alamofire

struct API {
    
    
    static func getMenus(completion: @escaping (MenuData?, NSError?) -> Void) {
        
        let url = Constant.MENU_SYSTEM_BASE_URL + "v1/location/boxi-park/all"
        
        let headers = [
            "Authorization": Constant.MENU_SYSTEM_API_KEY,
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(url,  method: .get, parameters: nil,encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            guard response.result.isSuccess else {
                
                if let err = response.result.error as? URLError, err.code == .notConnectedToInternet {
                    // no internet connection
                    completion(nil, NSError(domain: "No Internet Connection", code: 404, userInfo: nil))
                } else {
                   completion(nil, NSError(domain: "No data Available", code: 404, userInfo: nil))
                }
                
                
                return
            }
            do {
                let result =  try JSONDecoder().decode(MenuData.self, from: response.data!)
                completion(result, nil)
            }
            catch let _ {
                completion(nil, NSError(domain: "Invalid Request", code: 404, userInfo: nil))
            }
        }
    }
    
    
}
