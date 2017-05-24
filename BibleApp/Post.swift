//
//  Post.swift
//  BibleApp
//
//  Created by Ostap Romaniv on 5/15/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import ObjectMapper

class Post: NSObject, Mappable {
    
    // MARK: - Properties for Uploading Sermons:
    var pastor_name: String?
    var media_url: String?
    var sermon_title: String?
    var verse_id_array: [Int]?
    
    // MARK: - Properties for Uploading Music:
    var tag_scripture: [String]?
    var artist_name: String?
    var writer_name: String?
    var music_link: String?
    var song_story: String?
    
    // MARK: - Common Properties for Uploading Media Content:
    var message: String?
    var descript: String?
    var tags: [String]?
    
    
    func mapping(map: Map) {
        // Sermon Upload
        self.pastor_name    <- map["pastor_name"]
        self.media_url      <- map["media_url"]
        self.sermon_title   <- map["sermon_title"]
        self.verse_id_array <- map["verse_id_arr"]
        
        // Music Upload
        self.tag_scripture  <- map["tag_scripture"]
        self.artist_name    <- map["artist_name"]
        self.writer_name    <- map["writer_name"]
        self.music_link     <- map["music_link"]
        self.song_story     <- map["song_story"]
        
        // Commonly used mapped properties
        self.message        <- map["message"]
        self.descript       <- map["descript"]
        self.tags           <- map["tags"]
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
    
    static func uploadMusic(artist_name: String, writer_name: String, music_link: String, song_story: String, descript: String, tags: [String], tag_scripture: [String], user_id: Int, completion: @escaping (_ post: Post?, _ error: Error?) -> Void) {
        
        let api = LivingWordsAPI()
        
        api.uploadMusic(artist_name: artist_name, writer_name: writer_name, music_link: music_link, song_story: song_story, descript: descript, tags:tags, tag_scripture: tag_scripture, user_id: userID!, completion: completion)
    }
    
}
