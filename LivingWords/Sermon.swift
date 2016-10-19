//
//  Sermon.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/11/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import Foundation


class Sermon {
    
    //Structure of JSON- {} -> [ ] results -> {}. {}
    //so model controller will be [[String:[String :Any]] and the any will be the individual dictionaries I'm trying to access
    private let kTitle = "fullTitle"
    private let kDescription = "moreInfoText"
    private let kBibleText = "bibleText"
    private let kSermonDate = "preachDate"
    
    private let kAudioFile = "audioFileURL"
    private let kVideoFile = "videoFileURL"
    private let kSermonLength = "audioDurationInSeconds"
    private let kTextFile = "textFileURL"
    
    private let kSourceDictionary = "source"
    private let kChurchName = "displayName"
    private let kDenomination = "denomination"
    private let kChurchAboutUs = "aboutUs"
    private let kSpeaker = "minister"
    private let kChurchWebPage = "homePageURL"
    private let kChurchAddress = "address"
    private let kServiceTimes = "serviceTimes"
    private let kChurchImage = "albumArtURL"
    
    //properties
    let sermonTitle: String?
    let sermonDescription: String?
    let bibleText: String?
    let sermonPastor: String?
    let sermonDate: String?
    
    let audioFile: String?
    let videoFile: String?
    let sermonLength: Int?
    let sermonTranscript: String?
    
    let churchName: String?
    let churchAddress: String?
    let churchServiceTimes: String?
    let churchDenomination: String?
    let churchAbout: String?
    let churchWebSite: String?
    let churchImage: String?
    
    
    

    //failable initializer. Create a sermon out of the flatmapped sermon dictionaries created in the Sermon Controller file.
    init?(dictionary: [String: Any])
    {
        //second level dictionary responses
        guard let sermonTitle = dictionary[kTitle] as? String,
              let sermonDescription = (dictionary[kDescription] as? String?) ?? "",
              let bibleText = dictionary[kBibleText] as? String?,
              let sermonDate = (dictionary[kSermonDate] as? String?),
              let audioFile = dictionary[kAudioFile] as? String,
              let sermonLength = dictionary[kSermonLength] as? Int,
            
              //NOTE TO SELF: This initializer was failing because no none of the dictionaries had ALL of these value so the following with the empty strings are properties that I don't absolutely need and I'm okay with coming back null. 
              let videoFile = (dictionary[kVideoFile] as? String?) ?? "",
              let sermonTranscript = (dictionary[kSermonLength] as? String?) ?? "",
            
              let sourceDictionary = dictionary[kSourceDictionary] as? [String: Any],
              let churchServiceTimes = (sourceDictionary[kServiceTimes] as? String?) ?? "",
              let churchAbout = (sourceDictionary[kChurchAboutUs] as? String?) ?? "",
              let churchWebSite = (sourceDictionary[kChurchWebPage] as? String?) ?? "",
              let churchImage = (sourceDictionary[kChurchImage] as? String?) ?? "",
        
        
    
              let sermonPastor = sourceDictionary[kSpeaker] as? String,
              let churchName = sourceDictionary[kChurchName] as? String,
              let churchAddress = sourceDictionary[kChurchAddress] as? String,
              let churchDenomination = sourceDictionary[kDenomination] as? String
        
              else { return nil }
        
        self.sermonTitle = sermonTitle
        self.sermonDescription = sermonDescription
        self.bibleText = bibleText
        self.sermonDate = sermonDate
        self.audioFile = audioFile
        self.videoFile = videoFile
        self.sermonLength = sermonLength
        self.sermonTranscript = sermonTranscript
        self.sermonPastor = sermonPastor
        self.churchName = churchName
        self.churchAddress = churchAddress
        self.churchServiceTimes = churchServiceTimes
        self.churchDenomination = churchDenomination
        self.churchAbout = churchAbout
        self.churchWebSite = churchWebSite
        self.churchImage = churchImage 

   
        
    }

    

    
}


