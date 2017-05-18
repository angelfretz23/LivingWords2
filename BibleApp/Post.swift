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
    static func uploadSermon(pastor_name: String, media_url: String, sermon_title: String, descript: String, tags: [String], verse_id_array: [Int], completion: @escaping (_ user: [Post]?, _ error: Error?) -> Void)  {
        let api = LivingWordsAPI()
        
        api.uploadSermon(pastor_name: pastor_name, media_url: media_url, sermon_title: sermon_title, descript: descript, tags: tags, verse_id_array: verse_id_array, user_id: userID!, completion: completion)
        
    }
}
