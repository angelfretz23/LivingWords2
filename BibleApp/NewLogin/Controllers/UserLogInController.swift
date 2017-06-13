//
//  UserLogInController.swift
//  BibleApp
//
//  Created by Angel Contreras on 6/12/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import Foundation

final class UserLogInController: NSObject{
    
    private let keychain: KeychainSwift!
    
    private let keychainPrefixKey: String = "com.LivingWords412"
    
    static let shared = UserController()
    
    private enum KeychainKey: String {
        case userEmailKey = "LWEmail"
        case userPassword = "LWPassword"
    }
    
    init(){
        keychain = KeychainSwift(keyPrefix: keychainKey)
        super.init()
    }
    
    var userEmail: String?{
        get {
            return keychain.get(KeychainKey.userEmail.rawValue)
        }
        set {
            if let unwrappedNewValue = newValue {
                keychain.set(unwrappedNewValue, forKey: KeychainKey.userEmail.rawValue, withAccess: .accessibleWhenUnlocked)
            } else {
                keychain.delete(KeychainKey.userEmail.rawValue)
            }
        }
    }
    
    var userPassword: String?{
        get{
            return keychain.get(KeychainKey.userPassword.rawValue)
        }
        set {
            if let unwrappedNewValue = newValue {
                keychain.set(unwrappedNewValue, forKey: KeychainKey.userPassword.rawValue, withAccess: .accessibleWhenUnlocked)
            } else {
                keychain.delete(KeychainKey.userEmail.rawValue)
            }
        }
    }
}
