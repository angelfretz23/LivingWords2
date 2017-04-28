//
//  NetworkManager.swift
//  BibleApp
//
//  Created by Mac on 4/21/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import Alamofire


class LivingWordsAPI {
    
    // singelton
    static let instance = LivingWordsAPI()
     init(){}
    
    var service: ServiceProtocol = AlamofireService()
    
    
    
    // MARK: - Public methods
//    public func signUp(with email: String, password: Int) {
//        
//        Alamofire.request(URL(string: "dreadful-hog-5591.vagrantshare.com/api/users/login")!, method: .post, parameters: ["email": email, "password": password], encoding: JSONEncoding.default, headers: nil).response { (response) in
//            print("Response 🚁🏵🎯 \(response)")
//        }
//    }
//    
//    public func confirmEmail(email: String) {
//        Alamofire.request(URL(string: "dreadful-hog-5591.vagrantshare.com/api/users/reset")!, method: .post, parameters: ["email": email], encoding: JSONEncoding.default, headers: nil).response { (response) in
//            print("Response 🔴⚫️🔴 \(response)")
//        }
//    }
//    
//    public func checkThePassCode(code: Int) {
//        Alamofire.request(URL(string: "dreadful-hog-5591.vagrantshare.com/api/users/check")!, method: .post, parameters: ["code": code], encoding: JSONEncoding.default, headers: nil).response { (response) in
//            print("Response 🔴⚫️🔴 \(response)")
//        }
//    }
//    
//    public func confirmNewPassword(id: Int, password: String) {
//        Alamofire.request(URL(string: "dreadful-hog-5591.vagrantshare.com/api/users/success")!, method: .post, parameters: ["id": id, "password": password], encoding: JSONEncoding.default, headers: nil).response { (response) in
//            print("Response 🔴⚫️🔴 \(response)")
//        }
//    }
    
}

extension LivingWordsAPI {
    fileprivate enum Router: URLRequestConvertible {
        
        // User authorization
        
        case loginWithEmail(parameters: Parameters)
        
        case confirmEmail(parameters: Parameters)
        
        case checkThePassCode(parameters: Parameters)
        
        case confirmNewPassword(parameters: Parameters)
        
        private var baseURLString: String {
            return "http://fluttering-chipmunk-7893.vagrantshare.com/api"
        }
        
        //https://dreadful-hog-5591.vagrantshare.com/api
        
        private var path: String {
            switch self {
            case .loginWithEmail:
                return "/users/login"
                
            case .confirmEmail:
                return "/users/reset"
                
            case .checkThePassCode:
                return "/users/check"
                
            case .confirmNewPassword:
                return "/users/success"
            }
          
        }
        
        private var method: HTTPMethod {
            switch self {
            case .loginWithEmail, .confirmEmail, .checkThePassCode, .confirmNewPassword:
                return .post
                
            }
        }
        
        private var token: String {
            switch self {
            case .loginWithEmail, .confirmEmail, .checkThePassCode, .confirmNewPassword:
                return ""
            }
        }
        
        private var id: Int {
            switch self {
            case  .loginWithEmail, .confirmEmail, .checkThePassCode, .confirmNewPassword:
                return 0
            }
        }
        
        private func addHeadersForRequest( request: inout URLRequest) {
            request.setValue(token, forHTTPHeaderField: "token")
            request.setValue(String(id), forHTTPHeaderField: "user-id")
        }
        
        private func addParametersForRequest(request: URLRequest) throws -> URLRequest {
            var request = request
            switch self {
            case .loginWithEmail(let parameters):
                request = try JSONEncoding.default.encode(request, with: parameters)
                
            case .confirmEmail(let parameters):
                request = try JSONEncoding.default.encode(request, with: parameters)
                
            case .checkThePassCode(let parameters):
                request = try JSONEncoding.default.encode(request, with: parameters)
                
            case .confirmNewPassword(let parameters):
                request = try JSONEncoding.default.encode(request, with: parameters)
        
            }
            return request
        }
        
        
        //MARK: URLRequestConvertible
        
        func asURLRequest() throws -> URLRequest {
            let url = try baseURLString.asURL()
            
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            addHeadersForRequest(request: &urlRequest)
            urlRequest = try addParametersForRequest(request: urlRequest)
            
            return urlRequest
        }
        
    }
}

extension LivingWordsAPI {
    @discardableResult
    func login(withEmail email: String, password: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) -> DataRequest  {
        let request = Router.loginWithEmail(parameters: ["email"     : email,
                                                         "password"  : password])
        
        
        return service.request(request: request).responseObject(completionHandler: { (response: DataResponse<User>) in
            completion(response.result.value, response.result.error)
        })
    }
    
    func confirmEmail(email: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) -> DataRequest {
        let request = Router.confirmEmail(parameters: ["email" : email])
        
        return service.request(request: request).responseObject(completionHandler: { (response: DataResponse<User>) in
            completion(response.result.value, response.result.error)
        })
    }
    
    func checkThePassCode(code: Int, completion: @escaping (_ user: User?, _ error: Error?) -> Void) -> DataRequest {
        let request = Router.confirmEmail(parameters: ["code" : code])
        
        return service.request(request: request).responseObject(completionHandler: { (response: DataResponse<User>) in
            completion(response.result.value, response.result.error)
        })
    }
    
    func confirmNewPassword(id: Int, password: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) -> DataRequest {
        let request = Router.confirmEmail(parameters: ["id" : id, "password": password])
        
        return service.request(request: request).responseObject(completionHandler: { (response: DataResponse<User>) in
            completion(response.result.value, response.result.error)
        })
    }
    
}
