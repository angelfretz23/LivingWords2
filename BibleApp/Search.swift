//
//  Search.swift
//  BibleApp
//
//  Created by Igor Makara on 4/24/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import ObjectMapper

class Search: NSObject, Mappable {
    
    var matchingData: Search?
    var bookOfBible: String?
    var chapterNumberOfBook: String?
    var bibleBookVerse: Search?
    var verse: String?
    
    func mapping(map: Map) {
        self.matchingData               <- map["_matchingData"]
        self.bookOfBible                <- map["BooksOfBible"]
        self.chapterNumberOfBook        <- map["ChapterNumberOfBook"]
        self.bibleBookVerse             <- map["BibleBookVerse"]
        self.verse                      <- map["verse"]
    }
    
    required init?(map: Map) {
    
    }
}
extension Search {
    static func getBible(completion:@escaping (_ search: [Search]?, _ error: Error?) -> Void) {
        let api = LivingWordsAPI()
        
        api.getBible(completion: completion)
    }
}
//{
//    "id": 59,
//    "name": "NIV",
//    "_matchingData": {
//        "BooksOfBible": {
//            "id": 267,
//            "type": "book",
//            "version": "asv",
//            "book_name": "Exodus",
//            "direction": "LTR",
//            "bible_type_id": 59
//        },
//        "ChapterNumberOfBook": {
//            "id": 1279,
//            "books_of_bible_id": 267,
//            "chapter": 40
//        },
//        "BibleBookVerse": {
//            "id": 27,
//            "chapter_id": 1279,
//            "verse_number": 1,
//            "verse": "And Jehovah spake unto Moses, saying,"
//        }
//    }
//},
