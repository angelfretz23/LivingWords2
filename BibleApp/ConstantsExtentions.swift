//
//  ConstantsExtentions.swift
//  BibleApp
//
//  Created by Mac on 5/17/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import Foundation

var isUserLogenIn = false
let isUserLogenInKey = "isUserLogenIn"

var userContentType: String?
let userContentTypeKey = "userContentType"

var userEmail = "None"
let userEmailKey = "userEmail"

var userID: Int?
let userIDKey = "userID"

enum ContentProviderType {
    case User
    case Pastor
    case Artist
    case Author_Book
    case Author_Movie
}
