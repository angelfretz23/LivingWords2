//
//  Verse.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/11/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import Foundation

class Verse: Equatable {
    
    //Structure JSON- third/last level dictionary 
    private let kVerseNumber = "verse_nr"
    private let kVerseText = "verse"
    
    let verseNumber: Int
    let verseText: String

    //STEP 3: Model Objects - failable initializer, will be used in Chapter Model
    init?(dictionary: [String:Any])
    {
        guard let verseNumber = dictionary[kVerseNumber] as? Int,
            let verseText = dictionary[kVerseText] as? String else { return nil }
        
        self.verseNumber = verseNumber
        self.verseText = verseText
    }
}

/*
 init(verseNumber: Int, verseText: String)
 {
 self.verseNumber = verseNumber
 self.verseText = verseText
 }
 */
//MARK: Equatable
func == (lhs: Verse, rhs: Verse) -> Bool
{
    //chapters are considered equal if their properties match
    return lhs.verseNumber == rhs.verseNumber && lhs.verseText == rhs.verseText
}
