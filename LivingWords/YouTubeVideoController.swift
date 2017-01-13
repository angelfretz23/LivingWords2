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
    
    
    
    // MARK: - Singleton
    static let sharedController = YouTubeVideoController()

    
    
    var selectedVideos: [YouTube] = []
      
    
    

    
    
    //STEP 1: When a user selects one of the verses (didSelectCell) function, then call the getchSermon function
    
    let baseURL = URL(string: "https://www.googleapis.com/youtube/v3/videos")
    //static let endpoint = baseURL?.appendingPathExtension("json")
    
    func fetchYouTubeVideo(id: String,  completion: @escaping (YouTube?)-> Void) {
        
        let urlParameters = ["part": "snippet" , "id": id, "key": "AIzaSyDALO35jMftLoKLppczRc-sx7vHX0TFdgQ", "playsinline": "1"]

        
        guard let url = baseURL else {
            //Swift 3- this doesnt work completion(book = [])
            fatalError("URL optional is nil")
        }
        
        //make network call to get JSON back in NSData form
        NetworkController.performRequest(for: url, httpMethodString: "GET", urlParameters: urlParameters) {
            (data, error) in
            
            //unwrap data
            guard let data = data,
                let responseDataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                else {
                    print("Error: No data returned from network")
                    completion(nil)
                    return
            }
            print(data)
            
            
            
            if error != nil {
                print(error?.localizedDescription)
                //                print(error as! NSError)
                completion(nil)
            } else if responseDataString.contains("error") {
                print("Error: (\(responseDataString)")
                completion(nil)
            }
            
            //if there is no error but data returned, serialize the JSON data returned using the dataFromString above
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any],
                //                let jsonDictionary = jsonAnyObject as? [String: Any],
                let itemsArray = jsonDictionary["items"] as? [[String: Any]] else { return }
                let itemsDictionary = itemsArray[0]
                guard let snippetDictionary = itemsDictionary["snippet"] as? [String: Any]
                else {
                    print("Error: Unable to serialize returned JSON Data. \n Response: \(responseDataString)")
                    completion(nil)
                    return
                }
            
            
            //json returns everything in the snippetDictionary but we want the video returned to only have the traits we assigned in the YouTube objecg
            let video = YouTube(dictionary: snippetDictionary)
            completion(video)
            
        }
    }
}




