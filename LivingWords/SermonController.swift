//
//  SermonController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/14/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import Foundation

class SermonController {
    
     //STEP 1: When a user selects one of the verses (didSelectCell) function, then call the getchSermon function
    
    static let baseURL = URL(string: "https://api.sermonaudio.com/v1/node/sermons_by_bibref")
    //static let endpoint = baseURL?.appendingPathExtension("json")
    
    static func fetchSermon(bookName: String, chapterNumber: Int? , verseNumber: Int?, completion: @escaping ([Sermon?])-> Void) {
        
        guard let chapterNumber = chapterNumber, let verseNumber = verseNumber else { return }
        let urlParameters = ["bibbook": bookName, "bibchapter": "\(chapterNumber)", "bibverse": "\(verseNumber)"]
        
        let apiHeader = "8053A751-10C1-4093-BFE9-0C00C3374AA6"
        let forHTTPHeaderField = "x-api-key"
        
        guard let url = baseURL else {
            //Swift 3- this doesnt work completion(book = [])
            fatalError("URL optional is nil")
        }
        
        //make network call to get JSON back in NSData form
        NetworkController.performRequest(for: url, httpMethodString: "GET", urlParameters: urlParameters, apiHeader: apiHeader, forHTTPHeaderField: forHTTPHeaderField) {
            (data, error) in
            
            //unwrap data
            guard let data = data,
                  let responseDataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                else {
                    print("Error: No data returned from network")
                    completion([])
                    return
            }
            print(data)
            
    
            
            if error != nil {
                print(error?.localizedDescription)
//                print(error as! NSError) 
                completion([])
            } else if responseDataString.contains("error") {
              print("Error: (\(responseDataString)")
              completion([])
            }
            
            //if there is no error but data returned, serialize the JSON data returned using the dataFromString above
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any],
//                let jsonDictionary = jsonAnyObject as? [String: Any],
                let resultsArray = jsonDictionary["results"] as? [[String: Any]]
                else {
                    print("Error: Unable to serialize returned JSON Data. \n Response: \(responseDataString)")
                    completion([])
                    return
            }
            
            
            //go through the jsonDictionary returned and pull out the book which will be {book} and create a book object out of that
            print(jsonDictionary)
            let sermons = resultsArray.flatMap{Sermon(dictionary: $0)}
            completion(sermons)
            
        }
    }
}


