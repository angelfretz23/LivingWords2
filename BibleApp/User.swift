//
//  User.swift
//  BibleApp
//
//  Created by Igor Makara on 4/21/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//


import ObjectMapper

class User: NSObject, Mappable{
    
    var id: Int?
    var username: String?
    var token: String?
    var email: String?
    var password: String?

    //var code: Int?
    var phone: String?

    var code: String?
    

    
    func mapping(map: Map) {
        self.id             <- map["id"]
        self.username       <- map["username"]
        self.token          <- map["token"]
        self.email          <- map["email"]
        self.password       <- map["password"]
        self.code           <- map["code"]
        self.phone          <- map["phone"]
    }
    
    required init?(map: Map) {
        
    }
    
}

extension User {
    static func login(withEmail email: String, password: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void)  {
        let api = LivingWordsAPI()
        
        api.login(withEmail: email, password: password, completion: completion)
    }
    
    static func confirmEmail(email: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void)  {
        let api = LivingWordsAPI()
        
        api.confirmEmail(email: email, completion: completion)
        
    }
    
    static func checkThePassCode(code: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void)  {
        let api = LivingWordsAPI()
        
        api.checkThePassCode(code: code, completion: completion)

    }
    
    static func confirmNewPassword(id: Int, password: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void)  {
        let api = LivingWordsAPI()
        
        api.confirmNewPassword(id: id, password: password, completion: completion)
        
    }
    static func signUpWithEmail( email: String, password: String, phone: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) {
        let api = LivingWordsAPI()
    
        api.signUpWithEmail(email: email, password: password, phone: phone, completion: completion)
    }
    
    static func loginGoogle(id: String, email: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) {
        let api = LivingWordsAPI()
        api.loginGoogle(id: id, email: email, completion: completion)
    }
    
    static func loginFacebook(token: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) {
        let api = LivingWordsAPI()
        api.loginFacebook(token: token, completion: completion)
    }
}
