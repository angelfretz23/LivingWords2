//
//  ProfileMediaTableViewCell.swift
//  BibleApp
//
//  Created by Oleh on 5/25/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class ProfileMediaTableViewCell: UITableViewCell {
    
    struct Constants {
        static let ProfileCollectionViewCell = "ProfileCollectionViewCell"
        static let ProfileCollectionViewCellReuseID = "ProfileCollectionViewCellReuseID"
    }
    
    var musicInfoArray:     [User] = []
    var movieInfoArray:     [User] = []
    var sermonInfoArray:    [User] = []
    var bookInfoArray:      [User] = []
    
    var mediaForProfileController: ProfileViewController?
    
    var currentController: UIViewController? {
        get {
            if let MFPC =  self.mediaForProfileController {
                return MFPC
            } else {
                return UIViewController()
            }
        }
    }
    
    @IBOutlet weak var mediaTypeLabel: UILabel!
    
    @IBOutlet weak var profileMediaCollectionView: UICollectionView!
    
    var indexNumber: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileMediaCollectionView.delegate = self
        profileMediaCollectionView.dataSource = self
        
        profileMediaCollectionView.register(UINib(nibName: Constants.ProfileCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.ProfileCollectionViewCellReuseID)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func getData(userInfo: [User]?, index: Int){
        
        indexNumber = index
        
        switch index {
        case 0:
            musicInfoArray = userInfo!
            profileMediaCollectionView.reloadData()
        case 1:
            movieInfoArray = userInfo!
            profileMediaCollectionView.reloadData()
        case 2:
            sermonInfoArray = userInfo!
            profileMediaCollectionView.reloadData()
        case 3:
            bookInfoArray = userInfo!
            profileMediaCollectionView.reloadData()
            
        default:
            break
        }
        
    }
    
}

extension ProfileMediaTableViewCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let media_url = "https://www.youtube.com/watch?v=g5dH_KbMzjw"
        if let currController = currentController {
            
            let typeOfMedia = UIViewController.cheakTypeOfMedia(media_url: media_url)
            
            YTFPlayer.initWithAVPlayer(tableViewDataSource: currController as! UITableViewDataSource, type: typeOfMedia, media_url: media_url)
            
            YTFPlayer.showYTFView(viewController: currController)
        }
    }
}

extension ProfileMediaTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch indexNumber{
        case 0:
            print(musicInfoArray.count)
            
            return musicInfoArray.count
        case 1:
            return movieInfoArray.count
        case 2:
            return sermonInfoArray.count
        case 3:
            return bookInfoArray.count
        default:
            return 0
            
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ProfileCollectionViewCellReuseID, for: indexPath as IndexPath) as! ProfileCollectionViewCell
        // cell.itemNameLabel.text = musicInfoArray[indexPath.row].musicInfo?.artistName
        cell.itemNameLabel.text = "skdskdmfskdmfksdmfksdmfsdkfsdfs"
        //print(musicInfoArray[indexPath.row].musicInfo?.artistName)
        
                switch indexNumber{
                case 0:
                    cell.itemNameLabel.text = musicInfoArray[indexPath.row].musicInfo?.descriptionMusic
                    cell.itemDescriptionLabel.text = musicInfoArray[indexPath.row].musicInfo?.artistName
                    UIViewController.fetchYouTubeVideoInfo(with: cell.itemDescriptionLabel, imageYouTube: cell.videoInfoImageView, youTubeId: "Lf6El9jHdGg")
        
                case 1:
                    cell.itemNameLabel.text = movieInfoArray[indexPath.row].movieInfo?.movieName
                    cell.itemDescriptionLabel.text =  movieInfoArray[indexPath.row].movieInfo?.director
        
                case 2:
                    cell.itemNameLabel.text = sermonInfoArray[indexPath.row].sermonInfo?.sermonTitle
                    cell.itemDescriptionLabel.text = sermonInfoArray[indexPath.row].sermonInfo?.pastorName
        
                case 3:
                    cell.itemNameLabel.text = bookInfoArray[indexPath.row].bookInfo?.bookName
                    cell.itemDescriptionLabel.text = bookInfoArray[indexPath.row].bookInfo?.authorName
                    UIViewController.fetchYouTubeVideoInfo(with: cell.itemDescriptionLabel, imageYouTube: cell.videoInfoImageView, youTubeId: "g5dH_KbMzjw")
        
                default:
                    break
                }
        
        
        return cell
    }
}

extension ProfileMediaTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let heightView = collectionView.bounds.height
        let widthCell = collectionView.bounds.width
        let widthOfCollectionItem = widthCell * 0.5 - 5
        
        let heightCell = heightView
        //let widthCell = heightCell * 1.1
        let heightBook = heightView
        let widthBook = heightView * 0.7
        
        //        if typeOfCell == .Book {
        //            return CGSize(width: widthBook, height: heightBook)
        //        }
        
        return CGSize(width: widthOfCollectionItem, height: heightCell)
    }
    
}
