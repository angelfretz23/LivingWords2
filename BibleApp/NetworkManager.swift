//
//  NetworkManager.swift
//  BibleApp
//
//  Created by Mac on 4/21/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {

    // singelton
    static let instance = NetworkManager()
    private init(){}
 
    // MARK: - Public methods
    public func signUp(with email: String, password: Int) {

        Alamofire.request(URL(string: "dreadful-hog-5591.vagrantshare.com/api/users/login")!, method: .post, parameters: ["email": email, "password": password], encoding: JSONEncoding.default, headers: nil).response { (response) in
            print("Response 🚁🏵🎯 \(response.request)")
        }

    }

}
