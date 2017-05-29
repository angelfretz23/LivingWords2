//
//  User.swift
//  BibleApp
//
//  Created by Igor Makara on 4/21/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//


import ObjectMapper

class User: NSObject, Mappable {
    
    var id: Int?
    var user_id: Int?
    var username: String?
    var token: String?
    var email: String?
    var password: String?
    var phone: String?
    var code: String?
    var message: Int?
    var messageStr: String?
    var newPassword: String?
    var content_type: String?
    
    //UserProfileMedia
    var musicInfoArray: [User]?
    var musicInfo: User?
    var artistName: String?
    var writerName: String?
    var mediaUrl: String?
    var songStory: String?
    var descriptionMusic: String?
    
    
    var movieInfoArray: [User]?
    var movieInfo: User?
    var director: String?
    var movieLink: String?
    var movieName: String?
    var actors: String?
    
    var sermonInfoArray: [User]?
    var sermonInfo: User?
    var pastorName: String?
    var sermonTitle: String?
    var sermonDescription: String?
    
    
    var bookInfoArray: [User]?
    var bookInfo: User?
    var authorName: String?
    var bookName: String?
    var summary: String?
    

    
    func mapping(map: Map) {
        self.id             <- map["id"]
        self.user_id        <- map["user_id"]
        self.username       <- map["username"]
        self.token          <- map["access_token"]
        self.email          <- map["email"]
        self.password       <- map["password"]
        self.code           <- map["code"]
        self.phone          <- map["phone"]
        self.message        <- map["message"]
        self.messageStr     <- map["messageStr"]
        self.newPassword    <- map["new_password"]
        self.content_type   <- map["content_type"]
        
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
        self.bookInfo          <- map["book"]
        self.authorName         <- map["author_name"]
        self.bookName           <- map["book_name"]
        self.summary            <- map["summary"]
        
    }
    
    //    "id": 1,
    //    "author_name": "author",
    //    "media_link": "yotube.com/video",
    //    "book_name": "name of book",
    //    "publish_date": "now",
    //    "summary": "sum mmary"
    
//    "music": [
//    {
//    "id": 5,
//    "media_id": 1,
//    "media_type": "music",
//    "user_history_id": 6,
//    "music": {
//    "id": 1,
//    "artist_name": "artist",
//    "writer_name": "writer",
//    "media_url": "kasdjflksadjf/sadfsadfads/sadf",
//    "song_story": "kasldjflksadjflksajdf",
//    "description": "description",
//    "user_id": 234234
//    }
//    }
    
    
    required init?(map: Map) {
        
    }
    
}

extension User {
    static func getUserInfoMedia(filterMedia: String, userId: Int, completion: @escaping (_ user: User?, _ error: Error?) -> Void) {
        let api = LivingWordsAPI()
        
        api.getUserInfoMedia(filterMedia: filterMedia, userId: userId, completion: completion)
    }
    
    static func login(withEmail email: String, password: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void)  {
        let api = LivingWordsAPI()
        
        api.login(withEmail: email, password: password, completion: completion)
    }
    
    static func confirmEmail(email: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void)  {
        let api = LivingWordsAPI()
        
        api.confirmEmail(email: email, completion: completion)
        
    }
    
    static func checkThePassCode(code: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void)  {
        let api = LivingWordsAPI()
        
        api.checkThePassCode(code: code, completion: completion)
    
    }
    
    static func confirmNewPassword(user_id: Int, newPassword: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void)  {
        let api = LivingWordsAPI()
        
        api.confirmNewPassword(user_id: user_id, newPassword: newPassword, completion: completion)
        
    }
    
    static func signUpWithEmail( email: String, password: String, phone: String, content_type: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) {
        let api = LivingWordsAPI()
    
        api.signUpWithEmail(email: email, password: password, phone: phone, contentType: content_type, completion: completion)
    }
    
    static func loginGoogle(id: String, email: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) {
        let api = LivingWordsAPI()
        api.loginGoogle(id: id, email: email, completion: completion)
    }
    
    static func loginFacebook(token: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) {
        let api = LivingWordsAPI()
        api.loginFacebook(token: token, completion: completion)
    }
}
