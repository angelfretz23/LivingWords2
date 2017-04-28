//
//  MediaModel.swift
//  BibleApp
//
//  Created by Mac on 4/24/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import Foundation

enum MediaCellType {
    case Book
    case Other
}

public struct MediaModel {
    var title: String
    var items:[MediaModelCell]
    var typeOfMedia: MediaCellType
}