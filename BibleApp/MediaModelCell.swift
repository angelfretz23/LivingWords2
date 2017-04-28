//
//  MediaModelCell.swift
//  BibleApp
//
//  Created by Mac on 4/27/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import Foundation

public struct MediaModelCell {
    var imagePath: String
    var title: String
    var youtubeID: String?
    var titleBotton: String?
    
    init(imagePath: String, title: String, youtubeID: String? = nil, titleBotton: String? = nil) {
        self.imagePath = imagePath
        self.title = title
        self.youtubeID = youtubeID
        self.titleBotton = titleBotton
    }
}
