//
//  Alert.swift
//  Boxi Park Analytics App
//
//  Created by Atlas-Labs on 6/10/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    
    private static func showBasicAlert(on vc:UIViewController, with title: String, message: String){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        let messageFont = [NSAttributedString.Key.font: UIFont(name: Constant.NORMAL_FONT_NAME, size: 15.0)!]

        
        let messageAttrString = NSMutableAttributedString(string: message, attributes: messageFont)
        
        alert.setValue(messageAttrString, forKey: "attributedMessage")

        alert.view.tintColor = #colorLiteral(red: 0.9210870266, green: 0.4134199023, blue: 0.3156435788, alpha: 1)
        alert.addAction(UIAlertAction(title: "Try again", style: .destructive, handler: nil))
                
        DispatchQueue.main.async {
            
            let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
            subview.layer.cornerRadius  = 10
            subview.backgroundColor     = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            vc.present(alert, animated: true, completion: nil)
            
        }
    }
    
    private static func showAdavanceAlert(on vc:UIViewController, with title: String, message: String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: {(alert: UIAlertAction!) in vc.viewDidLoad(); vc.view.layoutIfNeeded()}))
        alert.addAction(UIAlertAction(title: "Back", style: .default, handler: {(alert: UIAlertAction!) in vc.dismiss(animated: true, completion: nil)}))
        DispatchQueue.main.async { vc.present(alert, animated: true, completion: nil) }
    }
    
    private static func showAdavanceAlertOneAction(on vc:UIViewController, with title: String, message: String){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        let messageFont = [NSAttributedString.Key.font: UIFont(name: Constant.NORMAL_FONT_NAME, size: 15.0)!]
        
        
        let messageAttrString = NSMutableAttributedString(string: message, attributes: messageFont)
        
        alert.setValue(messageAttrString, forKey: "attributedMessage")
        
        alert.view.tintColor = #colorLiteral(red: 0.9210870266, green: 0.4134199023, blue: 0.3156435788, alpha: 1)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: {(alert: UIAlertAction!) in vc.dismiss(animated: true, completion: nil)}))
        
        DispatchQueue.main.async {
            
            let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
            subview.layer.cornerRadius  = 10
            subview.backgroundColor     = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            vc.present(alert, animated: true, completion: nil)
            
        }
    }
    
    private static func showAdavanceAlertForConnectionLost(on vc:UIViewController, with title: String, message: String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {(alert: UIAlertAction!) in vc.dismiss(animated: true, completion: nil)}))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: {(alert: UIAlertAction!) in Alert.openWifiSettings()}))
        DispatchQueue.main.async { vc.present(alert, animated: true, completion: nil) }
    }

    static func showWIFIfaildAlert(on vc:UIViewController){
        showAdavanceAlertForConnectionLost(on: vc, with: Constant.NO_WIFI_ALERT_ERROR_MESSAGE_HEADER, message: Constant.NO_WIFI_ALERT_ERROR_MESSAGE_BODY)
    }

    static func showSlowNetworkDetectAlert(on vc:UIViewController){
        showBasicAlert(on: vc, with: Constant.SLOW_NETWORK_DETECT_ERROR_MESSAGE_HEADER, message: Constant.SLOW_NETWORK_DETECT_ERROR_MESSAGE_BODY)
    }

    static func showValidationErrorAlert(on vc:UIViewController, error: String){
        showBasicAlert(on: vc, with: Constant.VALIDATION_ERROR_MESSAGE_HEADER, message: error)
    }
    
    static func showServerErroAlert(on vc:UIViewController){
        showBasicAlert(on: vc, with: Constant.SERVER_SIDE_ERROR_MESSAGE_HEADER, message: Constant.SERVER_SIDE_ERROR_MESSAGE_BODY)
    }
    
    static func showFailReuqestAlert(on vc:UIViewController){
        showBasicAlert(on: vc, with: Constant.SERVER_SIDE_ERROR_MESSAGE_HEADER, message: Constant.FAILD_REUQEST_ERROR_MESSAGE_BODY)
    }
    
    static func showNoInterneErroAlert(on vc:UIViewController){
        showBasicAlert(on: vc, with: Constant.NO_INTERNET_ERROR_MESSAGE_HEADER, message: Constant.NO_INTERNET_ERROR_MESSAGE_BODY)
    }
    
    static func showInvalidUserNameAlert(on vc:UIViewController){
        showBasicAlert(on: vc, with: Constant.INVALID_LOGIN_ERROR_MESSAGE_HEADER, message: Constant.INVALID_LOGIN_ERROR_MESSAGE_BODY)
    }
    
    static func showInvalidCardAlert(on vc:UIViewController){
        showBasicAlert(on: vc, with: Constant.INVALID_CARD_ERROR_MESSAGE_HEADER, message: Constant.INVALID_CARD_ERROR_MESSAGE_BODY)
    }
    
    static func showForgetPasswordRequestSuccessAlert(on vc:UIViewController){
        showAdavanceAlertOneAction(on: vc, with: Constant.FORGOT_VC_SUCESS_HEADER_BODY, message: Constant.FORGOT_VC_SUCESS_MESSAGE_BODY)
    }
    
    //MARK: open Setting page
    private static func openWifiSettings() {

        let shared = UIApplication.shared
        let url = URL(string: UIApplication.openSettingsURLString)!
        
        if #available(iOS 10.0, *) {
            shared.open(url)
        } else {
            shared.openURL(url)
        }
    }
    
}
