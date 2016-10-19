//
//  Chapter.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/12/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import Foundation

class Chapter: Equatable  {
    
    //{} Structure JSON- second level has the chapter number and another dictionary of verses
   
    private let kChapterNumber = "chapter_nr"
    private let kVerseDictionaries = "chapter"
   
    let chapterNumber: Int
    let verses: [Verse]
    
    var identifier: String {
        return "\(chapterNumber)."
    }
    
    
    //STEP 2 Model Objects- failable initializer will be used in Book Model. Parse through verseDictionaries and create a Verse object using the failable initializer in the Verse Model Object 
    init?(dictionary: [String:Any]) {
        guard
            let chapterNumber = dictionary[kChapterNumber] as? Int,
            let verseDictionaries = dictionary[kVerseDictionaries] as? [String:[String:Any]] else { return nil }
        
        let verses = verseDictionaries.flatMap { Verse(dictionary: $0.value) }
        
        
        self.chapterNumber = chapterNumber
        self.verses = verses
    }
}



//Make Chapter conform to equatable protocol because we need to find the index of the chapter

//MARK: Equatable
func == (lhs: Chapter, rhs: Chapter) -> Bool
{
    //chapters are considered equal if their properties match 
    return  lhs.chapterNumber == rhs.chapterNumber && lhs.verses == rhs.verses
}



/*
 init(chapterNumber: Int, verses: [Verse]) {
 self.chapterNumber = chapterNumber
 self.verses = verses
 }
 */
