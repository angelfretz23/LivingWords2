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
}

extension LivingWordsAPI {
    fileprivate enum Router: URLRequestConvertible {
        
        // User authorization
        
        case loginWithEmail(parameters: Parameters)
        case getBible()
        
        // Search
        case searchBible(parameters: Parameters)
        
        case confirmEmail(parameters: Parameters)
        
        case checkThePassCode(parameters: Parameters)
        
        case confirmNewPassword(parameters: Parameters)
        
        private var baseURLString: String {
            return "http://superb-mustang-1404.vagrantshare.com/api"
        }
        
        //https://dreadful-hog-5591.vagrantshare.com/api
        
        private var path: String {
            switch self {
            case .loginWithEmail:
                return "/users/login"
                

            case .getBible:
                return "/bible"
                
            case .searchBible:
                return "/bible"
            
            
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

            case .getBible:
                return .get

            case .loginWithEmail, .confirmEmail, .checkThePassCode, .confirmNewPassword, .searchBible:

                return .post
                
            }
        }
        
        private var token: String {
            switch self {
            case .loginWithEmail, .confirmEmail, .checkThePassCode, .confirmNewPassword, .loginWithEmail, .getBible, .searchBible:

                return ""
            }
        }
        
        private var id: Int {
            switch self {
        case  .loginWithEmail, .confirmEmail, .checkThePassCode, .confirmNewPassword, .loginWithEmail, .getBible, .searchBible:

                return 0
            }
        }
        
        private func addHeadersForRequest( request: inout URLRequest) {
            //request.setValue(token, forHTTPHeaderField: "token")
            // request.setValue(String(id), forHTTPHeaderField: "user-id")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        private func addParametersForRequest(request: URLRequest) throws -> URLRequest {
            var request = request
            switch self {
            case .loginWithEmail(let parameters):
                request = try JSONEncoding.default.encode(request, with: parameters)

            case .getBible():
                request = try URLEncoding.httpBody.encode(request, with: [:])
                
            // Search
            case .searchBible(let parameters):
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
    
}
extension LivingWordsAPI {
    @discardableResult
    func getBible(completion: @escaping (_ search: [Search]?, _ error: Error?)-> Void) -> DataRequest{
        let request = Router.getBible()
        
        return service.request(request: request).responseArray(completionHandler: { (response: DataResponse<[Search]>) in
            completion(response.result.value, response.result.error)
            
            
        })
    }
}
//completion: @escaping(_ posts: [Post]?, _ error: Error?) -> Void) ->DataRequest? {
//    let request = Router.searchPosts(parameters: ["phrase": phrase])
//    
//    return service.request(request: request).responseArray(completionHandler: { (response: DataResponse<[Post]>) in
//        completion(response.result.value, response.result.error)
//    })
extension LivingWordsAPI {
    @discardableResult
    func searchBible(book: String, chapter: String, verse: String, completion: @escaping(_ search: [Search]?, _ error: Error?)-> Void) -> DataRequest{
        let request = Router.searchBible(parameters: ["book"    : book,
                                                      "chapter" : chapter,
                                                      "verse"   : verse])
        
        return service.request(request: request).responseArray(completionHandler:{ (response: DataResponse<[Search]>) in
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

