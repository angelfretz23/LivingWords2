//
//  AllMediaTVCell.swift
//  BibleApp
//
//  Created by Mac on 4/24/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class AllMediaTVCell: UITableViewCell {
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    fileprivate var mediaData: [Verse]?
    fileprivate var mediaController: MainMediaViewController?
    fileprivate var mediaForProfileController: ProfileViewController?
    fileprivate var mediaForContentProviderProfileController: ContentProviderProfileVC?
    fileprivate var typeOfCell = MediaCellType.Movie

    var currentController: UIViewController? {
        get {
            if let MC = self.mediaController {
                return MC
            } else if let MFPC =  self.mediaForProfileController {
                return MFPC
            } else if let MFCPPC = self.mediaForContentProviderProfileController {
                return MFCPPC
            } else {
                return UIViewController()
            }
        }
    }
    
    // MARK:- AllMediaTVCell`s life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    
        collectionView.register(UINib(nibName: "MediaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MediaCell")
        collectionView.register(UINib(nibName: "BookTypeCollectionVCell", bundle: nil), forCellWithReuseIdentifier: "BookTypeCollectionVCellID")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

private typealias CollectionDataSource = AllMediaTVCell
extension CollectionDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = mediaData?.count {
             return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch typeOfCell {
        case .Movie:
            return movieCell(collectionView, cellForItemAt: indexPath)
        case .Book:
            return bookCell(collectionView, cellForItemAt: indexPath)
        case .Music:
            return musicCell(collectionView, cellForItemAt: indexPath)
        case .Sermone:
            return sermonesCell(collectionView, cellForItemAt: indexPath)
        }
//  
//        if typeOfCell == .Book {
//            return bookCell(collectionView, cellForItemAt: indexPath)
//        }
//        
//        return mediaNotBookCell(collectionView, cellForItemAt: indexPath)
        
    }
}

private typealias CollectionDelegate = AllMediaTVCell
extension CollectionDelegate: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let heightView = collectionView.bounds.height
        let heightCell = heightView
        let widthCell = heightCell * 1.7
        let heightBook = heightView
        let widthBook = heightView * 0.7
  
        if typeOfCell == .Book {
            return CGSize(width: widthBook, height: heightBook)
        }
        
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let edgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0)
        return edgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let media_url = mediaData![indexPath.row].media_url {
            
            if let currController = currentController {
                
                let typeOfMedia = UIViewController.cheakTypeOfMedia(media_url: media_url)
                
                YTFPlayer.initWithAVPlayer(tableViewDataSource: currController as! UITableViewDataSource, type: typeOfMedia, media_url: media_url)
                
                YTFPlayer.showYTFView(viewController: currController)
                
                if let media = mediaController {
                    media.dismiss(animated: false, completion: nil)
                }
                
            }
        }
    }
    
}

private typealias PublicMethod = AllMediaTVCell
extension PublicMethod {
    
    public func fillData(mediaData: [Verse]?, controller: UIViewController, type: MediaCellType) {
        if let controller = controller as? MainMediaViewController {
            self.mediaData = mediaData
            mediaController = controller
        } else if let controller =  controller as? ProfileViewController {
            self.mediaData = mediaData
            mediaForProfileController = controller
        } else if let controller =  controller as? ContentProviderProfileVC {
            self.mediaData = mediaData
            mediaForContentProviderProfileController = controller
        }
        
        typeOfCell = type
        collectionView.reloadData()
    }
    
}

private typealias Configuration = AllMediaTVCell
extension Configuration {
    
    fileprivate func movieCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> MediaCollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCollectionViewCell
        if let cellData = mediaData {
            cell.title.text = cellData[indexPath.row].artist_name
            
            UIViewController.configureCellImageAndTitle(media_url: cellData[indexPath.row].movie_link, cell: cell)
        }
        
        return cell
    }
    
    fileprivate func musicCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> MediaCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCollectionViewCell
        if let cellData = mediaData {
            cell.title.text = cellData[indexPath.row].artist_name
            UIViewController.configureCellImageAndTitle(media_url: cellData[indexPath.row].media_url, cell: cell)
            
        }
        
        return cell
    }
    
    fileprivate func sermonesCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> MediaCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCollectionViewCell
        if let cellData = mediaData {
            cell.title.text = cellData[indexPath.row].artist_name
            UIViewController.configureCellImageAndTitle(media_url: cellData[indexPath.row].media_url, cell: cell)
        }
        
        return cell
    }
    
    fileprivate func bookCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> BookTypeCollectionVCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookTypeCollectionVCellID", for: indexPath) as! BookTypeCollectionVCell
        cell.title.text = "Book"
        cell.imageBook.image = #imageLiteral(resourceName: "great-gatsby-coverjpg")
        cell.titleBottom.text = "Rostik"
        
        return cell
    }
    
    fileprivate func mediaNotBookCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> MediaCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCollectionViewCell
        if let cellData = mediaData {
            cell.title.text = cellData[indexPath.row].artist_name
            
            if typeOfCell == .Movie {
                UIViewController.configureCellImageAndTitle(media_url: cellData[indexPath.row].movie_link, cell: cell)
            } else {
                UIViewController.configureCellImageAndTitle(media_url: cellData[indexPath.row].media_url, cell: cell)
            }

        }
        
        return cell
    }
}
