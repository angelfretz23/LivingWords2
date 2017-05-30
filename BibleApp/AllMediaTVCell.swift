//
//  AllMediaTVCell.swift
//  BibleApp
//
//  Created by Mac on 4/24/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit
import SVProgressHUD

class AllMediaTVCell: UITableViewCell {
    
    // MARK:- IBOutlets
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var verse: Verse?
    fileprivate var mediaData: [Verse]?
    fileprivate var mediaController: MainMediaViewController?
    fileprivate var mediaForProfileController: ProfileViewController?
    fileprivate var mediaForContentProviderProfileController: ContentProviderProfileVC?
    fileprivate var typeOfCell = Media.movies
    
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
        case .movies:
            return UICollectionViewCell.movieCell(collectionView, cellForItemAt: indexPath, mediaData: mediaData, isFromProfileVC: false)
        case .books:
            return UICollectionViewCell.bookCell(collectionView, cellForItemAt: indexPath, mediaData: mediaData, isFromProfileVC: false)
        case .music:
            return UICollectionViewCell.musicCell(collectionView, cellForItemAt: indexPath, mediaData: mediaData, isFromProfileVC: false)
        case .sermons:
            return UICollectionViewCell.sermonesCell(collectionView, cellForItemAt: indexPath, mediaData: mediaData, isFromProfileVC: false)
        default:
            print("")
        }
        
        return UICollectionViewCell()
    }
}

private typealias CollectionDelegate = AllMediaTVCell
extension CollectionDelegate: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightView = collectionView.bounds.height
        let heightCell = heightView
        let widthCell = heightCell * 1.7
        let heightBook = heightView
        let widthBook = heightView * 0.7
        
        if typeOfCell == .books {
            return CGSize(width: widthBook, height: heightBook)
        }
        
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0)
        return edgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let media_url = collectionView.mediaUrlDependOnType(indexPath: indexPath, mediaData: mediaData, typeOfCell: typeOfCell) {
            
            if let currController = currentController {
                
                let typeOfMedia = UIViewController.cheakTypeOfMedia(media_url: media_url)
                
                YTFPlayer.initWithAVPlayer(tableViewDataSource: currController as! UITableViewDataSource, type: typeOfMedia, media_url: media_url, verse: verse!, isFromProfileVC: false)
                
                YTFPlayer.showYTFView(viewController: currController)
                
                if let media = mediaController {
                    media.dismiss(animated: false, completion: nil)
                }
                
                Verse.saveToHistory(media_id: (mediaData?[indexPath.row].id)!, madia_type: String(describing: typeOfCell), user_id: userID!, completion: { success in
                    if success {
                        SVProgressHUD.showSuccess(withStatus: "Saved")
                    }
                })
                
                YTFPlayer.getMediaId(mediaId: (mediaData?[indexPath.row].id)!)
            }
        }
    }
    
}


private typealias PublicMethod = AllMediaTVCell
extension PublicMethod {
    
    public func fillData(mediaData: [Verse]?, controller: UIViewController, type: Media) {
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
    
    fileprivate func mediaNotBookCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> MediaCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCollectionViewCell
        if let cellData = mediaData {
            cell.title.text = cellData[indexPath.row].artist_name
            
            if typeOfCell == .movies {
                UIViewController.configureCellImageAndTitle(media_url: cellData[indexPath.row].movie_link, cell: cell)
            } else {
                UIViewController.configureCellImageAndTitle(media_url: cellData[indexPath.row].media_url, cell: cell)
            }
        }
        return cell
    }
    
}
