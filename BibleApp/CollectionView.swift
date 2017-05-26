//
//  CollectionView.swift
//  BibleApp
//
//  Created by Mac on 5/26/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func mediaUrlDependOnType(indexPath: IndexPath, mediaData: [Verse]?, typeOfCell: Media) -> String? {
        
        var media_url: String?
        
        switch typeOfCell{
        case .sermons:
            media_url = mediaData?[indexPath.row].media_url
            
        case .movies:
            media_url = mediaData?[indexPath.row].movie_link
            
        case .music:
            media_url = mediaData?[indexPath.row].media_url
            
        case .books:
            media_url = mediaData?[indexPath.row].media_link
            
        case .allMedia:
            media_url = "Sorry"
            
        }
        
        return media_url
    }
}
