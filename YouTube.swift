//
//  YouTubeVideo.swift
//  LivingWords
//
//  Created by Chandi Abey  on 11/12/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import Foundation


class YouTube: NSObject, MediaSource

{
        var sourceType: Provider = .youtube
        //Structure of JSON- {} -> [ ] results -> {}. {}
        //so model controller will be [[String:[String :Any]] and the any will be the individual dictionaries I'm trying to access
        private let kChannelID = "channelId"
        private let kVideoTitle = "title"
        private let kVideoDescription = "description"
        private let kVideoThumbnails = "thumbnails"
        private let kDefaultThumbnails = "default"
        

        //properties
        let channelID: String
        let videoTitle: String
        let videoDescription: String
        let videoThumbnail: String 

    
  
    
        //failable initializer. Create a video out of the flatmapped youtube dictionaries created in the YouTubeVideo Controller file.
        init?(dictionary: [String: Any])
        {
            //second level dictionary responses
            guard let channelID = dictionary[kChannelID] as? String,
                let videoTitle = dictionary[kVideoTitle] as? String,
                let videoDescription = dictionary[kVideoDescription] as? String,
                let thumbnailDictionary = dictionary[kVideoThumbnails] as? [String: Any],
            let defaultThumbnailDictionary = thumbnailDictionary[kDefaultThumbnails] as? [String: Any],
            let videoThumbnail = defaultThumbnailDictionary["url"] as? String

                
                else { return nil }
            
            self.channelID = channelID
            self.videoTitle = videoTitle
            self.videoDescription = videoDescription
            self.videoThumbnail = videoThumbnail
        }
    
    
    
}
