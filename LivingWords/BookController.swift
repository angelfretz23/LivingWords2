//
//  BookController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/12/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import Foundation

class BookController {
    
    static let sharedController = BookController()
    
    //STEP 1: Create an array of books of the bible hardcoded. Use this array to populate the book table view controller
    static let arrayOfBooksInBible = ["GEN", "EXO", "LEV", "NUM", "DEU", "JOS", "JDG", "RUT", "1SA", "2SA", "1KI", "2KI", "1CH", "2CH", "EZR", "NEH", "EST", "JOB", "PSA", "PRO", "ECC", "SOS", "ISA", "JER", "LAM", "EZE", "DAN", "HOS", "JOE", "AMO", "OBA", "JON", "MIC", "NAH", "HAB", "ZEP", "HAG", "ZEC", "MAL", "MAT", "MAR", "LUK", "JOH", "ACTS", "ROM", "1CO", "2CO", "GAL", "EPH", "PHP", "COL", "1TH", "2TH", "1TI", "2TI", "TIT", "PHM", "HEB", "JAM", "1PE", "2PE", "1JO", "2JO", "3JO", "JDE", "REV"]
    
    
    //STEP 2: When a user selects one of the books in the table view, make a network call to pull JSON values and convert into a Book Object
    static let baseURL = URL(string: "http://getbible.net/json")
    //static let endpoint = baseURL?.appendingPathExtension("json")
    
    static func fetchBook(bookName: String, completion: @escaping (Book?)-> Void) {
        let urlParameters = ["version": "asv","passage": "\(bookName)"]
        
        guard let url = baseURL else {
            //Swift 3- this doesnt work completion(book = [])
            fatalError("URL optional is nil")
        }
        
        //make network call to get JSON back in NSData form
        NetworkController.performRequest(for: url, httpMethodString: "GET", urlParameters: urlParameters) {
            (data, error) in
            
            //unwrap data
            guard let data = data
                else {
                    print("Error: No data returned from network")
                    completion(nil)
                    return
            }
            
            //STEP 2A
            //JSON data came back with () and ; at the end because this is JSONP formatting so we need to remove these characters.
            //step 1- converting data to string
            guard var stringFromData = String.init(data: data, encoding: String.Encoding.utf8) else {
                return
            }
            
            //step 2- define the character set to remove from string
            let characterSet = CharacterSet.init(charactersIn: "( )")
            
            //step 3- turn the string into an array of characters 
            var charactersInStringArray = stringFromData.characters
            
            //step 4- remove the last character which is the semicolon
            charactersInStringArray.removeLast()
            
            //step 5- combine the array of characters back into a string
            stringFromData = String.init(charactersInStringArray)
            
            //step 6- trim the characters from the string
            let string = stringFromData.trimmingCharacters(in: characterSet)
            
            //step 7- convert the string to data 
            guard let dataFromString = string.data(using: String.Encoding.utf8) else {
                return
            }
            
            
            
            
            //check if error occurred
            if error != nil {
                print(error?.localizedDescription)
                completion(nil)
            } //else if responseDataString.contains("error") {
            // print("Error: (\(responseDataString)")
            //completion(nil)

            
            
           
            //if there is no error but data returned, serialize the JSON data returned using the dataFromString above
            guard let jsonAnyObject = (try? JSONSerialization.jsonObject(with: dataFromString, options: .allowFragments)),
                let jsonDictionary = jsonAnyObject as? [String: AnyObject]
                
                else {
                //print("Error: Unable to serialize returned JSON Data. \n Response: \(responseDataString)")
                completion(nil)
                return
            }
            
            
            //go through the jsonDictionary returned and pull out the book which will be {book} and create a book object out of that 
            let book = Book(jsonDictionary: jsonDictionary)
            completion(book)
            
            }
        }
    
    
    
    
    
    
    

    //function to retrieve bookName and chapterNumber selected - ASK ANGEL- re: global and local variables
/*
func retrieveBookAndChapterFromListSelection(bookName: String, chapterNumber: Int) -> [Verse]
    {
        BookController.fetchBook(bookName: bookName)
        { (book) in
            var unsortedVerses =  book?.chapters[chapterNumber - 1].verses
            let verses = unsortedVerses?.sorted(by: {$0.verseNumber < $1.verseNumber})
        }
     
    //Functions for verse object
    //select verse and highlight verse?)
}   //select verse and takes notes
    //select verse and call up sermon objects
  */  
}
    
    protocol VerseControllerDelegate: class {
    
    func highlightVerseTextOneClick(verse: Verse)
}
