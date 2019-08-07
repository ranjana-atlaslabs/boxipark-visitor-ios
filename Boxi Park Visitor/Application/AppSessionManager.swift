//
//  SessionManager.swift
//  AATO
//
//  Created by Ranjana on 26/2/18.
//  Copyright © 2018 Ranjana. All rights reserved.
//

import UIKit

class AppSessionManager: NSObject {
    
    public static let SESSION_MANAGER_STORE_AUTH_TOKEN = "com.atlaslabs.BOXI.SESSION_MANAGER_STORE_AUTH_TOKEN";
    public static let SESSION_MANAGER_STORE_REFRESH_TOKEN = "com.atlaslabs.BOXI.SESSION_MANAGER_STORE_REFRESH_TOKEN";
    public static let SESSION_MANAGER_STORE_PRINTED_CARD_NUMBER = "com.atlaslabs.BOXI.SESSION_MANAGER_STORE_PRINTED_CARD_NUMBER";
    
    public static let SESSION_MANAGER_STORE_AUTH_USER_NAME = "com.atlaslabs.BOXI.SESSION_MANAGER_STORE_AUTH_USER_NAME";
    public static let SESSION_MANAGER_STORE_AUTH_PASSWORD = "com.atlaslabs.BOXI.SESSION_MANAGER_STORE_AUTH_PASSWORD";
   public static let SESSION_MANAGER_STORE_AUTH_FIRST_NAME = "com.atlaslabs.BOXI.SESSION_MANAGER_STORE_AUTH_FIRST_NAME";
    public override init() {
    }
    
    //save user's authentication token
    static func saveAuthToken(token: String) {
        UserDefaults.standard.set(token, forKey: AppSessionManager.SESSION_MANAGER_STORE_AUTH_TOKEN)
    }
    //get user's authentication token
    static func getAuthToken() -> String? {
        return UserDefaults.standard.string(forKey: AppSessionManager.SESSION_MANAGER_STORE_AUTH_TOKEN)
    }
    
    //save user's refresh token
    static func saveRefreshToken(token: String) {
        UserDefaults.standard.set(token, forKey: AppSessionManager.SESSION_MANAGER_STORE_REFRESH_TOKEN)
    }
    
    //get user's refresh token
    static func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: AppSessionManager.SESSION_MANAGER_STORE_REFRESH_TOKEN)
    }
    
    //save user's authentication user name
    static func saveAuthUserName(userName: String) {
        UserDefaults.standard.set(userName, forKey: AppSessionManager.SESSION_MANAGER_STORE_AUTH_USER_NAME)
    }
    //get user's authentication user name
    static func getAuthUserName() -> String? {
        return UserDefaults.standard.string(forKey: AppSessionManager.SESSION_MANAGER_STORE_AUTH_USER_NAME)
    }
    
    //save user's authentication user name
    static func saveAuthFirstName(userName: String) {
        UserDefaults.standard.set(userName, forKey: AppSessionManager.SESSION_MANAGER_STORE_AUTH_FIRST_NAME)
    }
    //get user's authentication user name
    static func getAuthFirstName() -> String? {
        return UserDefaults.standard.string(forKey: AppSessionManager.SESSION_MANAGER_STORE_AUTH_FIRST_NAME)
    }
    
    //save user's authentication password
    static func saveAuthPassword(password: String) {
        UserDefaults.standard.set(password, forKey: AppSessionManager.SESSION_MANAGER_STORE_AUTH_PASSWORD)
    }
    //get user's authentication password
    static func getAuthPassword() -> String? {
        return UserDefaults.standard.string(forKey: AppSessionManager.SESSION_MANAGER_STORE_AUTH_PASSWORD)
    }
    
    //save user's PrintedCardNumber
    static func savePrintedCardNumber(number: String) {
        UserDefaults.standard.set(number, forKey: AppSessionManager.SESSION_MANAGER_STORE_PRINTED_CARD_NUMBER)
    }
    //get user's PrintedCardNumber
    static func getPrintedCardNumber() -> String? {
        return UserDefaults.standard.string(forKey: AppSessionManager.SESSION_MANAGER_STORE_PRINTED_CARD_NUMBER)
    }
    
    //remove object for given key from user defaults
    static func removeObject(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    
    //remove all saved objects from user defaults
    static func removeAllObject() {
        if let identifier = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: identifier)
            UserDefaults.standard.synchronize()
        }
    }

}
