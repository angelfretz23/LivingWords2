//
//  Post.swift
//  BibleApp
//
//  Created by Ostap Romaniv on 5/15/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import ObjectMapper

class Post: NSObject, Mappable {
    
    var pastor_name: String?
    var media_url: String?
    var sermon_title: String?
    var descript: String?
    var tags: [String]?
    var verse_id_array: [Int]?
    
    func mapping(map: Map) {
        self.pastor_name    <- map["pastor_name"]
        self.media_url      <- map["media_url"]
        self.sermon_title   <- map["sermon_title"]
        self.descript       <- map["descript"]
        self.tags           <- map["tags"]
        self.verse_id_array <- map["verse_id_arr"]
    }
    
    required init?(map: Map) {
        
    }
    
}

extension Post {
    static func uploadSermon(pastor_name: String, media_url: String, sermon_title: String, descript: String, tags: [String], verse_id_array: [Int], completion: @escaping (_ user: Post?, _ error: Error?) -> Void)  {
        let api = LivingWordsAPI()
        
        api.uploadSermon(pastor_name: pastor_name, media_url: media_url, sermon_title: sermon_title, descript: descript, tags: tags, verse_id_array: verse_id_array, user_id: userID!, completion: completion)
    }
    
    static func uploadMovie(director: String, actors: String, media_url: String,
                            verse_id_array: [Int], movieName: String, releaseData: String,
                            synoopsis: String , tags: [String], completion: @escaping (_ post: Post?, _ error:Error?) -> Void) {
        let api = LivingWordsAPI()
        
        api.uploadMovie(director: director, actors: actors, media_url: media_url, verse_id_array: verse_id_array, movieName: movieName, releaseData: releaseData, synoopsis: synoopsis, tags: tags, user_id: userID!, completion: completion)
    }
    
    static func uploadBook(author_name: String, media_link: String, tag_scripture: [Int], book_name: String, publish_date: String,
                           summary: String , tags: [String], completion: @escaping (_ post: Post?, _ error:Error?) -> Void) {
        let api = LivingWordsAPI()
        
        api.uploadBook(author_name: author_name, media_link: media_link,
                       tag_scripture: tag_scripture, book_name: book_name,
                       publish_date: publish_date, symmary: summary, tags: tags, completion: completion)
        
    }
    
}
