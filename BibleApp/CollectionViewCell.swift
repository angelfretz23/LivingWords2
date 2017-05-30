//
//  CollectionViewCell.swift
//  BibleApp
//
//  Created by Mac on 5/29/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {

    static func movieCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, mediaData: [Verse]?) -> MediaCollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCollectionViewCell
        if let cellData = mediaData {
            cell.title.text = cellData[indexPath.row].artist_name
            cell.image.image = #imageLiteral(resourceName: "image-slider-2")
            UIViewController.configureCellImageAndTitle(media_url: cellData[indexPath.row].movie_link, cell: cell)
        }
        
        return cell
    }
    
    static func musicCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, mediaData: [Verse]?) -> MediaCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCollectionViewCell
        if let cellData = mediaData {
            cell.image.image = #imageLiteral(resourceName: "image-slider-2")
            cell.title.text = cellData[indexPath.row].artist_name
            UIViewController.configureCellImageAndTitle(media_url: cellData[indexPath.row].media_url, cell: cell)
            
        }
        
        return cell
    }
    
    static func sermonesCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, mediaData: [Verse]?) -> MediaCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCollectionViewCell
        if let cellData = mediaData {
            cell.image.image = #imageLiteral(resourceName: "image-slider-2")
            cell.title.text = cellData[indexPath.row].artist_name
            UIViewController.configureCellImageAndTitle(media_url: cellData[indexPath.row].media_url, cell: cell)
        }
        
        return cell
    }
    
    static func bookCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath,  mediaData: [Verse]?) -> BookTypeCollectionVCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookTypeCollectionVCellID", for: indexPath) as! BookTypeCollectionVCell
        cell.title.text = mediaData?[indexPath.row].book_name
        cell.imageBook.image = #imageLiteral(resourceName: "great-gatsby-coverjpg")
        cell.titleBottom.text = mediaData?[indexPath.row].author_name
        
        return cell
    }
}
