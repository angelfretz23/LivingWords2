//
//  BookController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/12/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import Foundation

class BookController {
    
    static let sharedController = BookController()
    
    func serializeJSON(completion: ([Book]) -> Void) {
        
        let filePath = Bundle.main.path(forResource: "BibleJSON", ofType: "json")!
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
            let serializedData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let jsonDictionary = serializedData as? [String:Any],
            let bookArray = jsonDictionary["books"] as? [[String:Any]] else { return }
        
        let books = bookArray.flatMap { Book(dictionary: $0) }
        completion(books)
    }
    
}
