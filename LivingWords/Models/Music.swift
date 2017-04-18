//
//  Music.swift
//  LivingWords
//
//  Created by Chandi Abey  on 1/3/17.
//  Copyright © 2017 Chandi Abey . All rights reserved.
//

import Foundation
import Firebase

class Music: NSObject {
    
    let key: String
    let artistName: String
    let releaseDate: String?
    let relevantLyrics: String
    let songName: String
    let songStory: String
    let youTubeVideoId: String
    let hashtags: String
    let ref: FIRDatabaseReference?
    
    init(artistName: String, releaseDate: String, relevantLyrics: String, songName: String, songStory: String, youTubeVideoId: String, hashtags: String, key: String = "")
    {
        self.key = key
        self.artistName = artistName
        self.releaseDate = releaseDate
        self.relevantLyrics = relevantLyrics
        self.songName = songName
        self.songStory = songStory
        self.youTubeVideoId = youTubeVideoId
        self.hashtags = hashtags
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot)
    {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: Any]
        artistName = snapshotValue["artist_name"] as! String
        releaseDate = snapshotValue["release_date"] as? String
        relevantLyrics = snapshotValue["relevant_lyrics"] as! String
        songName = snapshotValue["song_name"] as! String
        songStory = snapshotValue["song_story"] as! String
        youTubeVideoId = snapshotValue["youTube_video_id"] as! String
        hashtags = snapshotValue["hashtags"] as! String
        ref = snapshot.ref
    }
    
    
    
}

