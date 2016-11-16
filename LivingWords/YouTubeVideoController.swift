//
//  YouTubeVideoController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 11/12/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import Foundation

class YouTubeVideoController
{
    
    //define URL and URL parameters which will both be included as parameters in the NetworkController performRequest call
    static let baseURL = NSURL(string:"http://api.themoviedb.org/3/search/movie")
    
    
    //make this function static so we dont need a singleton or need to create an instance of moviecontroller in another class to access the fetchmovie function in another file/class
//    static func fetchMovie(searchTerm: String, completion: ((_ movies: [Movie]) -> Void)?) {
//        
//        let urlParameters = ["query": "\(searchTerm)", "api_key": "cf94204e2c9c89c99eb2506b4b69970a"]
//        
//        guard let url = baseURL else {
//            print("Error: NO URL Found")
//            completion?(movies: [])
//            return
//        }
//        
//        //make network call to get JSON in NSData form back
//        NetworkController.performRequestForURL(url, httpMethod: .Get, urlParameters: urlParameters) { (data, error) in
//            
//            //unwrap data
//            guard let data = data,
//                let responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else {
//                    print("Error: No data returned")
//                    completion?(movies: [])
//                    return
//            }
    
            
            //check if error returned
            
}
