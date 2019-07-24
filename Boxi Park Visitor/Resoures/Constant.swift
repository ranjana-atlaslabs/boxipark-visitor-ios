//
//  Constant.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 6/3/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation

struct Constant {
    
    
    public static let MENU_SYSTEM_BASE_URL    = "https://customer-api.singleplatform.com/"
    public static let MENU_SYSTEM_API_KEY     = "SPC:uFklLNNnmjdA3Qe1R6zqKg:v0YAO590OMSlHRS7hoe7jlOGJGU"
    
    public static let OPEN_WEATHER_MAP        = "798133ac41c425102ded214330e37a67"
    public static let OFFLINE_DATA_ON         = false
    
    public static let RETURENT_LOCAL_DATA: [ResturentLocalData]  = [
        ResturentLocalData(id: 0 ,name: "Barnona", logo: #imageLiteral(resourceName: "barnonalogon"), color: #colorLiteral(red: 0.9520129561, green: 0.9357979894, blue: 0.893722713, alpha: 1)),
        ResturentLocalData(id: 0 ,name: "Canonita", logo: #imageLiteral(resourceName: "barnonalogon"), color: #colorLiteral(red: 0.7740916014, green: 0.3885799944, blue: 0.2412629426, alpha: 1)),
        ResturentLocalData(id: 0 ,name: "La Cajita", logo: #imageLiteral(resourceName: "lacajitalogon"), color: #colorLiteral(red: 0.9653725028, green: 0.835703373, blue: 0.556709826, alpha: 1)),
        ResturentLocalData(id: 0 ,name: "Fowl Play", logo: #imageLiteral(resourceName: "fowl flay"), color: #colorLiteral(red: 0.7598508, green: 0.2347533405, blue: 0.190864265, alpha: 1)),
        ResturentLocalData(id: 0 ,name: "Hops and Vine", logo: #imageLiteral(resourceName: "hopslogon"), color: #colorLiteral(red: 0.2463579476, green: 0.3117541969, blue: 0.3831449151, alpha: 1)),
        ResturentLocalData(id: 0 ,name: "The Grill Next Door", logo: #imageLiteral(resourceName: "grilllogon"), color: #colorLiteral(red: 0.9520129561, green: 0.9357979894, blue: 0.893722713, alpha: 1)),
        ResturentLocalData(id: 0 ,name: "Claw & Order", logo: #imageLiteral(resourceName: "clawlogon"), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
        ResturentLocalData(id: 0 ,name: "Naughty & Nice", logo: #imageLiteral(resourceName: "naughtylogon"), color: #colorLiteral(red: 0.4114020467, green: 0.6439546347, blue: 0.5185563564, alpha: 1)),
        ResturentLocalData(id: 0 ,name: "Barxi Park", logo: #imageLiteral(resourceName: "barxilogon"), color: #colorLiteral(red: 0.133510083, green: 0.1185990497, blue: 0.1235295162, alpha: 1)),
        ResturentLocalData(id: 0 ,name: "Before It Melts", logo: #imageLiteral(resourceName: "beforelogon"), color: #colorLiteral(red: 0.1140215024, green: 0.3539430797, blue: 0.4238928854, alpha: 1))
    ]
    
    public static let NORMAL_FONT_NAME   = "Gotham-Book"
    
    public static let WAIT_MESSAGE_TEXT        = "Please wait..."
    public static let VALIDATING_MESSAGE_TEXT  = "Validating..."
    //Paytronix Api information
    
    public static let PAYTRONIX_BASE_URL = "https://api.pxslab.com:443/rest/19.23/"
    public static let MERCHANT_ID        = 508
    public static let CARD_TEMPLATE_CODE = 7
    public static let SOTRE_CODE         = "corp"
    
    public static let CLIENT_ID          = "V89673jnA72839A-237Ih23kj623hjksa732hHS722"
    public static let SECRET             = "Nk28Sh2j*2ds"
    
    public static let PAYTRONIX_API_SUCCESS_RESULT              = "success"
    public static let PAYTRONIX_API_CARD_CREATED_SUCCESS_RESULT = "cardCreatedSuccess"
    public static let PAYTRONIX_API_USER_EXISTS_RESULT          = "uniquenessConflict"
    public static var MINIMUM_PASSWORD_CHARACHTERS              = 8
    public static var ANONYMOUS_AUTH_TYPE                       = "anonymous"
    public static var AUTH_AUTH_TYPE                            = "oauth"
    //-------------------------------
    
    public static var SHOW_ERROR_MSG = false
    
    //Error Messages
    public static let NO_WIFI_ALERT_ERROR_MESSAGE_HEADER        = "Celluar Data is Turned Off"
    public static let NO_WIFI_ALERT_ERROR_MESSAGE_BODY          = "Turn on cellular data or use Wi-Fi to access data"
    
    public static let SLOW_NETWORK_DETECT_ERROR_MESSAGE_HEADER  = ""
    public static let SLOW_NETWORK_DETECT_ERROR_MESSAGE_BODY    = "Slow network detected"
    
    public static let SERVER_SIDE_ERROR_MESSAGE_HEADER          = "Error"
    public static let SERVER_SIDE_ERROR_MESSAGE_BODY            = "Paytronix server unreachable"
    public static let FAILD_REUQEST_ERROR_MESSAGE_BODY          = "Request faild"
    
    public static let NO_INTERNET_ERROR_MESSAGE_HEADER          = "Error"
    public static let NO_INTERNET_ERROR_MESSAGE_BODY            = "No Internet Connection"
    
    public static let VALIDATION_ERROR_MESSAGE_HEADER           = "Error"
    public static let USERNAME_REQUIRED_MESSAGE_BODY            = "Username is required"
    public static let FULL_NAME_REQUIRED_MESSAGE_BODY           = "Full name can't be empty"
    public static let CARD_REQUIRED_MESSAGE_BODY                = "Loyalty card number is required"
    public static let REG_CARD_REQUIRED_MESSAGE_BODY            = "Register number is required"
    public static let EMAIL_REQUIRED_MESSAGE_BODY               = "Email is required"
    public static let MOBILE_REQUIRED_MESSAGE_BODY              = "Mobile number is required"
    public static let MOBILE_EMPTY_MESSAGE_BODY                 = "Mobile number can't be empty"
    public static let PASSWORD_REQUIRED_MESSAGE_BODY            = "Password is required"
    
    public static let EMAIL_INVALID_MESSAGE_BODY                = "Invalid email"
    public static let MOBILE_INVALID_MESSAGE_BODY               = "Invalid mobile number"
    public static let PASSWORD_INVALID_MESSAGE_BODY             = "Password should have 7 more characters"
    public static let USER_ALLREADY_EXSITS_MESSAGE_BODY         = "User already exist in the system"
    public static let INVALID_PHONE_NUMBER_MESSAGE_BODY         = "Invalid mobile number"
    
    public static let INVALID_LOGIN_ERROR_MESSAGE_HEADER        = "Error"
    public static let INVALID_LOGIN_ERROR_MESSAGE_BODY          = "Invalid username or password"
    
    public static let INVALID_CARD_ERROR_MESSAGE_HEADER         = "Error"
    public static let INVALID_CARD_ERROR_MESSAGE_BODY           = "Invalid card credentials"
    
    public static let FORGOT_VC_ERROR_MESSAGE_BODY              = "Email is required"
    public static let FORGOT_VC_SUCESS_MESSAGE_BODY             = "Request is success. Check your mail"
    public static let FORGOT_VC_SUCESS_HEADER_BODY              = "Success"

    public static let PROFILE_UPDATE_MESSAGE_BODY               = "Profile update success"
}
