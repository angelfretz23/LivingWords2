//
//  Verse.swift
//  BibleApp
//
//  Created by Mac on 5/23/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import Foundation
import ObjectMapper

public class Verse : Mappable {

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
    var message: String?
    
    public func mapping(map: Map) {
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
        self.message                <- map["message"]
    }
    
    required public init?(map: Map) {
        
    }
    
}

extension Verse {
    
    static func verseMedia( verse_id: Int, completion: @escaping (_ post: Verse?, _ error:Error?) -> Void) {
        let api = LivingWordsAPI()
        
        api.verseMedia(verse_id: verse_id, completion: completion)
    }
    
    static func saveToHistory(media_id: Int, madia_type: String, user_id: Int, completion: @escaping (_ success: Bool) -> Void) {
        let api = LivingWordsAPI()
        
        api.saveToHistory(media_id: media_id, madia_type: madia_type, user_id: user_id, completion: completion)
    }
    
    static func saveToFavorites(media_id: Int, madia_type: String, user_id: Int, completion: @escaping (_ success: Bool) -> Void) {
        let api = LivingWordsAPI()
        
        api.saveToFavorites(media_id: media_id, madia_type: madia_type, user_id: user_id, completion: completion)
    }
    
}
