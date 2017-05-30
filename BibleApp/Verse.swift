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

    var book_name: String?
    var author_name: String?


    
    
    //UserProfileMedia
    var musicInfoArray: [Verse]?
    var musicInfo: Verse?
    var artistName: String?
    var writerName: String?
    var mediaUrl: String?
    var songStory: String?
    var descriptionMusic: String?
    
    
    var movieInfoArray: [Verse]?
    var movieInfo: Verse?
    var director: String?
    var movieLink: String?
    var movieName: String?
    var actors: String?
    
    var sermonInfoArray: [Verse]?
    var sermonInfo: Verse?
    var pastorName: String?
    var sermonTitle: String?
    var sermonDescription: String?
    
    
    var bookInfoArray: [Verse]?
    var bookInfo: Verse?
    var authorName: String?
    var bookName: String?
    var summary: String?
    var bookMediaUrl: String?
    

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

        self.book_name              <- map["book_name"]
        self.author_name            <- map["author_name"]


        
        
        //MusicMediaInfo
        self.musicInfoArray     <- map["music"]
        self.musicInfo          <- map["music"]
        self.artistName         <- map["artist_name"]
        self.writerName         <- map["writer_name"]
        self.mediaUrl           <- map["media_url"]
        self.songStory          <- map["song_story"]
        self.descriptionMusic   <- map["description"]
        
        //MovieMediaInfo
        self.movieInfoArray     <- map["movie"]
        self.movieInfo          <- map["movie"]
        self.director           <- map["director"]
        self.movieLink          <- map["movie_link"]
        self.movieName          <- map["movie_name"]
        self.actors             <- map["actors"]
        
        
        //SermonMediaInfo
        self.sermonInfoArray     <- map["sermon"]
        self.sermonInfo          <- map["sermon"]
        self.pastorName          <- map["description"]
        self.sermonTitle         <- map["semon_title"]
        self.sermonDescription   <- map["description"]
        
        //BookMediaInfo
        self.bookInfoArray      <- map["book"]
        self.bookInfo            <- map["book"]
        self.authorName         <- map["author_name"]
        self.bookName           <- map["book_name"]
        self.summary            <- map["summary"]
        self.bookMediaUrl       <- map["media_link"]
        

    }
    
    required public init?(map: Map) {
        
    }
    
}

extension Verse {
    
    static func getUserInfoMedia(filterMedia: String, userId: Int, completion: @escaping (_ user: Verse?, _ error: Error?) -> Void) {
        let api = LivingWordsAPI()
        
        api.getUserInfoMedia(filterMedia: filterMedia, userId: userId, completion: completion)
    }
    
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
