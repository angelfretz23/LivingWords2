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
        
        // Post
        case uploadSermon(parameters: Parameters)
        
        case uploadMovie(parameters: Parameters)
        

        case uploadMusic(parameters: Parameters)

        case verseMedia(parameters: Parameters)
        
        case uploadBook(parameters: Parameters)

        
        // Search
        case searchBible(parameters: Parameters)
        
        case confirmEmail(parameters: Parameters)
        
        case checkThePassCode(parameters: Parameters)
        
        case confirmNewPassword(parameters: Parameters)
        
        case signUpWithEmail(parameters: Parameters)
        
        case loginFacebook(parameters: Parameters)
        
        case loginGoogle(parameters: Parameters)
        
        //User
        case getUserInfoMedia(filterMedia: String, parameters: Parameters)
        
        private var baseURLString: String {
            return "http://bible.binariks.com/api"
        }

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
                
            case .signUpWithEmail:
                return "/users/register"
                
            case .loginFacebook:
                return "/users/facebook"
                
            case .loginGoogle:
                return "/users/google"
                
            case .uploadSermon:
                return "/seremon"
                
            case .uploadMovie:
                return "/movie"

                
            case .uploadMusic:
                return "/music"


             
            case .verseMedia:
                return "/verse/get"
            
            case .uploadBook:
                return "/book"
                
                //User
            case .getUserInfoMedia(let filterMedia, _):
                print("/profile/" + filterMedia)
                
                return "/profile/" + filterMedia

            }
          
        }
        
        private var method: HTTPMethod {
            switch self {

            case .getBible:
                return .get

            case .loginWithEmail, .confirmEmail, .checkThePassCode,
                 .confirmNewPassword, .searchBible, .signUpWithEmail,

                 .loginFacebook, .loginGoogle, .uploadSermon, .uploadMovie,
                 .uploadMusic, .verseMedia, .uploadBook, .getUserInfoMedia:

             

                return .post
                
            }
        }
        
        private var token: String {
            switch self {
            case  .confirmEmail, .checkThePassCode, .confirmNewPassword,
                 .loginWithEmail, .getBible, .searchBible, .signUpWithEmail,
                 .loginFacebook, .loginGoogle, .uploadSermon, .uploadMovie,
                 .uploadMusic, .uploadBook, .verseMedia, .getUserInfoMedia:

                return ""
            }
        }
        
        private var id: Int {
            switch self {
        case .confirmEmail, .checkThePassCode, .confirmNewPassword,
              .loginWithEmail, .getBible, .searchBible, .signUpWithEmail,
              .loginFacebook, .loginGoogle, .uploadSermon, .uploadMovie, .uploadMusic, .uploadBook,.verseMedia:

                return 0
            default:
                return 6
            }
        }
        
        private func addHeadersForRequest( request: inout URLRequest) {
           // if let token = userToken {
                
                request.setValue("4f2d910c5bcda14fb2b577793a50b9b547fc843b3a87aa63cc9de5e15b3889ca", forHTTPHeaderField: "Access-token")
                //request.setValue(token, forHTTPHeaderField: "Access-token")
                // request.setValue(String(id), forHTTPHeaderField: "user-id")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            //}
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
                
            case .signUpWithEmail(let parameters):
                request = try JSONEncoding.default.encode(request, with: parameters)
              
            case .loginFacebook(let parameters):
                request = try JSONEncoding.default.encode(request, with: parameters)
                
            case .loginGoogle(let parameters):
                request = try JSONEncoding.default.encode(request, with: parameters)
                
            case .uploadSermon(let parameters):
                request = try JSONEncoding.default.encode(request, with: parameters)
                
            case .uploadMovie(let parameters):
                request = try JSONEncoding.default.encode(request, with: parameters)
                
            case .uploadMusic(let parameters):
                request = try JSONEncoding.default.encode(request, with: parameters)

            case .verseMedia(let parameters):
                request = try JSONEncoding.default.encode(request, with: parameters)
                
            case .uploadBook(let parameters):

                request = try JSONEncoding.default.encode(request, with: parameters)
                
            case .getUserInfoMedia(_, let parameters):
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
    
    @discardableResult
    func signUpWithEmail( email: String, password: String, phone: String, contentType: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) -> DataRequest  {
        let request = Router.signUpWithEmail(parameters: ["email"   : email,
                                                         "password" : password,
                                                         "phone"    : phone,
                                                         "content_type": contentType])
        
        return service.request(request: request).responseObject(completionHandler: { (response: DataResponse<User>) in
            completion(response.result.value, response.result.error)
        })
    }
    
    @discardableResult
    func loginFacebook(token: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) -> DataRequest {
        let request = Router.loginFacebook(parameters: ["token" : token,
                                                         "type" : 1 ])
        
        return service.request(request: request).responseObject(completionHandler: { (response: DataResponse<User>) in
            completion(response.result.value, response.result.error)
        })
    }
    
    @discardableResult
    func loginGoogle(id: String, email: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) -> DataRequest {
        let request = Router.loginGoogle(parameters: ["id" : id,
                                                    "type" : 2,
                                                   "email" : email ])
        
        return service.request(request: request).responseObject(completionHandler: { (response: DataResponse<User>) in
            completion(response.result.value, response.result.error)
        })
    }
}


extension LivingWordsAPI {
    //User
    @discardableResult
    func getUserInfoMedia(filterMedia: String, userId: Int, completion: @escaping (_ user: User?, _ error: Error?) -> Void) -> DataRequest  {
        
        print(filterMedia)
        print(userId)
        
        let request = Router.getUserInfoMedia(filterMedia: filterMedia, parameters: ["user_id": userId])
        
        return service.request(request: request).responseObject(completionHandler: { (response: DataResponse<User>) in
            completion(response.result.value, response.result.error)
         
        })
    }
    
    @discardableResult
    func getBible(completion: @escaping (_ search: [Search]?, _ error: Error?) -> Void) -> DataRequest {
        
        let request = Router.getBible()
        
        return service.request(request: request).responseArray(completionHandler: { (response: DataResponse<[Search]>) in
            completion(response.result.value, response.result.error)
            
        })
    }
    
    
    @discardableResult
    func searchBible(book: String, chapter: String, verse: String, completion: @escaping(_ search: [Search]?, _ error: Error?)-> Void) -> DataRequest {
        
        let request = Router.searchBible(parameters: ["book" : book,
                                                   "chapter" : chapter,
                                                     "verse" : verse])
        
        return service.request(request: request).responseArray(completionHandler:{ (response: DataResponse<[Search]>) in
            completion(response.result.value, response.result.error)
        })
    }
    
    @discardableResult
    func confirmEmail(email: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) -> DataRequest {
        
        let request = Router.confirmEmail(parameters: ["email" : email])
        
        return service.request(request: request).responseObject(completionHandler: { (response: DataResponse<User>) in
            completion(response.result.value, response.result.error)
        })
    }
    
    @discardableResult
    func checkThePassCode(code: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) -> DataRequest {
        
        let request = Router.checkThePassCode(parameters: ["code" : code])
        
        return service.request(request: request).responseObject(completionHandler: { (response: DataResponse<User>) in
            completion(response.result.value, response.result.error)
            
        })
    }
    
    @discardableResult
    func confirmNewPassword(user_id: Int, newPassword: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) -> DataRequest {
        let request = Router.confirmNewPassword(parameters: ["user_id" : user_id,
                                                         "new_password": newPassword])
        
        
        return service.request(request: request).responseObject(completionHandler: { (response: DataResponse<User>) in
            completion(response.result.value, response.result.error)
            
        })
    }
    
    @discardableResult
    func uploadSermon(pastor_name: String, media_url: String, sermon_title: String, descript: String, tags: [String], verse_id_array: [Int], user_id: Int, completion: @escaping (_ post: Post?, _ error:
        Error?) -> Void) -> DataRequest {
        let request = Router.uploadSermon(parameters: ["pastor_name" : pastor_name,
                                                         "media_url" : media_url,
                                                      "sermon_title" : sermon_title,
                                                          "descript" : descript,
                                                              "tags" : tags,
                                                      "verse_id_arr" : verse_id_array,
                                                           "user_id" : user_id])
        
        return service.request(request: request).responseObject(completionHandler: { (response: DataResponse<Post>) in
            completion(response.result.value, response.result.error)
        
        })
    }
    
    @discardableResult
    func uploadMovie(director: String, actors: String, media_url: String,verse_id_array: [Int], movieName: String, releaseData: String, synoopsis: String, tags: [String], user_id: Int, completion: @escaping (_ post: Post?, _ error: Error?) -> Void) -> DataRequest {
        
        let request = Router.uploadMovie(parameters: ["director" : director,
                                                        "actors" : actors,
                                                    "movie_link" : media_url,
                                                    "movie_name" : movieName,
                                                  "release_data" : releaseData,
                                                     "synoopsis" : synoopsis,
                                                          "tags" : tags,
                                                  "verse_id_arr" : verse_id_array])
        
        return service.request(request: request).responseObject(completionHandler: { (response: DataResponse<Post>) in
            completion(response.result.value, response.result.error)
        })
    }
    
    @discardableResult
    func uploadMusic(artist_name: String, writer_name: String, music_link: String, song_story: String, descript: String, tags: [String], tag_scripture: [String], user_id: Int, completion:
        @escaping (_ post: Post?, _ error: Error?) -> Void) -> DataRequest {
        
        let request = Router.uploadMusic(parameters: ["artist_name" : artist_name,
                                                      "writer_name" : writer_name,
                                                       "music_link" : music_link,
                                                       "song_story" : song_story,
                                                         "descript" : descript,
                                                             "tags" : tags,
                                                    "tag_scripture" : tag_scripture,
                                                          "user_id" : user_id
                                                                                    ])

    
        return service.request(request: request).responseObject(completionHandler: { (response: DataResponse<Post>) in
            completion(response.result.value, response.result.error)
        })
    }
    
    @discardableResult
    func verseMedia(verse_id: Int, completion: @escaping (_ post: Verse?, _ error:
        Error?) -> Void) -> DataRequest {
        
        let request = Router.verseMedia(parameters: ["verse" : verse_id])
        
        return service.request(request: request).responseObject(completionHandler: { (response: DataResponse<Verse>) in
            completion(response.result.value, response.result.error)
            
        })
    }
    @discardableResult
    func uploadBook(author_name: String, media_link: String, tag_scripture: [String],
                    book_name: String, publish_date: String, symmary: String, tags: [String], completion: @escaping (_ post: Post?, _ error:
        Error?) -> Void) -> DataRequest {
        
        let request = Router.uploadBook(parameters: ["author_name" : author_name,
                                                      "media_link" : media_link,
                                                      "tag_scripture" : tag_scripture,
                                                      "book_name" : book_name,
                                                      "publish_date": publish_date,
                                                      "summary": symmary,
                                                      "tags": tags])
        
        return service.request(request: request).responseObject(completionHandler: { (response: DataResponse<Post>) in
            completion(response.result.value, response.result.error)
            
        })
    }
}
