//
//  APIErrorHandling.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/8/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//


import Foundation
import UIKit

struct APIErrorHandling {
    
    init(error: Error, vc: UIViewController) {
        
        switch (error._code){
            
        case NSURLErrorTimedOut:
            
            //Manager time out error
            Alert.showSlowNetworkDetectAlert(on: vc)
            
            break
            
        case NSURLErrorNotConnectedToInternet:
            
            //Manager not connected to internet error
            
            if  Constant.SHOW_ERROR_MSG  {
                
                Alert.showWIFIfaildAlert(on: vc)
                Constant.SHOW_ERROR_MSG = false
                
            }
            
            break
            
        default:
            
            //Manager server error
            if (error._code == URLError.Code.notConnectedToInternet.rawValue || error._code  == -1003) && Constant.SHOW_ERROR_MSG{
                Alert.showNoInterneErroAlert(on: vc)
                Constant.SHOW_ERROR_MSG = false
            }
                
            else if error._code != NSURLErrorCancelled && error._code != 53 && error._code != -1005 && Constant.SHOW_ERROR_MSG {
                
                Alert.showServerErroAlert(on: vc)
                Constant.SHOW_ERROR_MSG = false
            }
            
            break
            
        }
        
    }
    
    
}
