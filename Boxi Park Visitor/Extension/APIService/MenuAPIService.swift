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
    
    static func getMenus(completion: @escaping (MenuData?, Error?) -> Void) {
        
        let url = Constant.MENU_SYSTEM_BASE_URL + "v1/location/boxi-park/all"
        
        let headers = [
            "Authorization": Constant.MENU_SYSTEM_API_KEY,
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(url,  method: .get, parameters: nil,encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
                
            case .success(_):
                do {
                    let result =  try JSONDecoder().decode(MenuData.self, from: response.data!)
                    completion(result, nil)
                }
                catch let err {
                    completion(nil, err)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
}
