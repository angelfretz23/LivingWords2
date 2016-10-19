//
//  Book.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/12/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import Foundation

class Book: Equatable {
    
    //Structure of JSON- {} first level dictionary has bookName and ChapterDictionaries called "book"
    private let kBookName = "book_name"
    private let kChapterDictionaries = "book"
    
    let bookName: String
    let chapters: [Chapter]

    
   
    
    //STEP 1 Model Objects: failable initializer. Create a chapter out of the flatmapped chapter dictionaries. Refer to failable initializer in Chapter Object. 
    init?(jsonDictionary: [String: Any])
    {
        //first level dictionary- on the first level we have the bookName and dictionary of chapters in {book}
        guard let bookName = jsonDictionary[kBookName] as? String,
            let chapterDictionaries = jsonDictionary[kChapterDictionaries] as? [String: [String: Any]] else { return nil }
        
        let chapters = chapterDictionaries.flatMap { Chapter(dictionary: $0.value) }
        
        self.bookName = bookName
        self.chapters = chapters
    }
}



//MARK: Equatable
func == (lhs: Book, rhs: Book) -> Bool
{
    //chapters are considered equal if their properties match
    return lhs.bookName == rhs.bookName && lhs.chapters == rhs.chapters
}



/*
 //second level, going into {book} which contains the chapter dictionaries, each contains the chapter number and a verse dictionary
 for chapters in chapterDictionaries {
 
 guard let chapter = chapterDictionaries[kChapterNumber] as? Int else { return nil }
 chapters.append(chapter)
 
 //third level, we are in the chapterDictionary and going in one level deeper to the verseDictionary
 for verseDictionary in chapter {
 guard let verseNumber = verseDictionary[kVerseNumber] as? Int,
 let verseText = verseDictionary[kVerseText] as? String
 else { return nil }
 }
 */
