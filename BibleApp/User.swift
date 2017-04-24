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
    
    
    
    func mapping(map: Map) {
        self.id             <- map["id"]
        self.username       <- map["username"]
        self.token          <- map["token"]
        
    }
    
    required init?(map: Map) {
        
    }
    
}
extension User {
    static func login(withEmail email: String, password: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void)  {
        let api = LivingWordsAPI()
        
        api.login(withEmail: email, password: password) { user, error in
       
        }
    }
}
