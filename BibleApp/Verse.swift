//
//  Verse.swift
//  BibleApp
//
//  Created by Mac on 5/23/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import Foundation
import ObjectMapper

class Verse : Mappable {

    var movie: [Verse]?
    var music: [Verse]?
    var sermon: [Verse]?
    var book: [Verse]?
    
    var id: Int?
    var artist_name: String?
    var writer_name: String?
    var media_url: String?
    var song_story: String?
    var description: String?
    var user_id: String?
    var movie_link: String?
    var media_link: String?
    
    func mapping(map: Map) {
        self.id                     <- map["id"]
        self.artist_name            <- map["artist_name"]
        self.writer_name            <- map["writer_name"]
        self.media_url              <- map["media_url"]
        self.song_story             <- map["song_story"]
        self.description            <- map["description"]
        self.user_id                <- map["user_id"]
        self.movie                  <- map["movie"]
        self.sermon                 <- map["sermon"]
        self.music                  <- map["music"]
        self.book                   <- map["book"]
        self.movie_link             <- map["movie_link"]
        self.media_link             <- map["media_link"]
    }
    
    required init?(map: Map) {
        
    }
    
}

extension Verse {
    
    static func verseMedia( verse_id: Int, completion: @escaping (_ post: Verse?, _ error:Error?) -> Void) {
        let api = LivingWordsAPI()
        
        api.verseMedia(verse_id: verse_id, completion: completion)
    }
}
