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

    static func movieCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, mediaData: [Verse]?, isFromProfileVC: Bool) -> MediaCollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCollectionViewCell
        if let cellData = mediaData?[indexPath.row] {
            
            let movieTitle: String = (isFromProfileVC ? cellData.movieInfo?.director : cellData.director)!
            let mediaUrl: String = (isFromProfileVC ? cellData.movieInfo?.movieLink : cellData.movie_link)!
            
            cell.title.text = movieTitle
            cell.image.image = #imageLiteral(resourceName: "image-slider-2")
            UIViewController.configureCellImageAndTitle(media_url: mediaUrl, cell: cell)
//            
//            cell.title.text = cellData[indexPath.row].artist_name
//            cell.image.image = #imageLiteral(resourceName: "image-slider-2")
//            UIViewController.configureCellImageAndTitle(media_url: cellData[indexPath.row].movie_link, cell: cell)
            
        }
        
        return cell
    }
    
    static func musicCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, mediaData: [Verse]?, isFromProfileVC: Bool) -> MediaCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCollectionViewCell
        if let cellData = mediaData?[indexPath.row] {
            
            let musicTitle: String = (isFromProfileVC ? cellData.musicInfo?.artistName : cellData.artist_name)!
            let mediaUrl: String = (isFromProfileVC ? cellData.musicInfo?.mediaUrl : cellData.media_url ?? "")!
            
            cell.title.text = musicTitle
            cell.image.image = #imageLiteral(resourceName: "image-slider-2")
            UIViewController.configureCellImageAndTitle(media_url: mediaUrl, cell: cell)
            
//            if isFromProfileVC {
//                
//                cell.title.text = cellData[indexPath.row].musicInfo?.artistName
//                cell.image.image = #imageLiteral(resourceName: "image-slider-2")
//                UIViewController.configureCellImageAndTitle(media_url: cellData[indexPath.row].musicInfo?.mediaUrl, cell: cell)
//            }else {
//            cell.image.image = #imageLiteral(resourceName: "image-slider-2")
//            cell.title.text = cellData[indexPath.row].artist_name
//            UIViewController.configureCellImageAndTitle(media_url: cellData[indexPath.row].media_url, cell: cell)
//            }
//        }
        }
        return cell
    }
    
    static func sermonesCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, mediaData: [Verse]?, isFromProfileVC: Bool) -> MediaCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCollectionViewCell
        if let cellData = mediaData?[indexPath.row] {
            
            var sermone: String?
            var mediaUrl: String?
            
            sermone = isFromProfileVC ? cellData.sermonInfo?.pastorName : cellData.artist_name
            mediaUrl = isFromProfileVC ? cellData.sermonInfo?.media_url : cellData.media_url
            
            cell.title.text = sermone
            cell.image.image = #imageLiteral(resourceName: "image-slider-2")
            UIViewController.configureCellImageAndTitle(media_url: mediaUrl, cell: cell)
      
        }
        
        return cell
    }
    
    static func bookCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath,  mediaData: [Verse]?, isFromProfileVC: Bool) -> BookTypeCollectionVCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookTypeCollectionVCellID", for: indexPath) as! BookTypeCollectionVCell
        
        if let cellData = mediaData?[indexPath.row] {
            var bookName = isFromProfileVC ? cellData.bookInfo?.bookName : cellData.bookName
            var bookAuthor = isFromProfileVC ? cellData.bookInfo?.authorName : cellData.authorName
            var mediaUrl = isFromProfileVC ? cellData.bookInfo?.media_link : cellData.media_link
        
        
        cell.title.text = bookName
        cell.imageBook.image = #imageLiteral(resourceName: "great-gatsby-coverjpg")
        cell.titleBottom.text = bookAuthor
    }
        return cell
    }
}
