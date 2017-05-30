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
    
    var musicInfoArray:     [Verse] = []
    var movieInfoArray:     [Verse] = []
    var sermonInfoArray:    [Verse] = []
    var bookInfoArray:      [Verse] = []
    var verse : Verse?
    
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
    
    var typeOfCell: String = ""
    
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
    
    func getVerse(verseInfo: Verse){
        verse = verseInfo
    }
    
    func getData(userInfo: [Verse]?, index: Int, cellType: String){
        
        indexNumber = index
        typeOfCell = cellType
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
        var  media_url: String?
        
        switch typeOfCell{
            case "music":
            media_url = musicInfoArray[indexPath.row].musicInfo?.mediaUrl
            case "movie":
            media_url = movieInfoArray[indexPath.row].movieInfo?.movieLink
            case "sermon":
            media_url = sermonInfoArray[indexPath.row].sermonInfo?.mediaUrl
            case "book":
            media_url = bookInfoArray[indexPath.row].bookInfo?.bookMediaUrl
        default:
            break
        }
        if let currController = currentController {

            let typeOfMedia = UIViewController.cheakTypeOfMedia(media_url: media_url!)
            
            YTFPlayer.initWithAVPlayer(tableViewDataSource: currController as! UITableViewDataSource, type: typeOfMedia, media_url: media_url!, verse: verse!, isFromProfileVC: true)
            
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
        //print(musicInfoArray[indexPath.row].musicInfo?.artistName)
        
                switch indexNumber{
                case 0:
                    cell.itemNameLabel.text = musicInfoArray[indexPath.row].musicInfo?.descriptionMusic
                    cell.itemDescriptionLabel.text = musicInfoArray[indexPath.row].musicInfo?.artistName
                    if  let youTubeId = musicInfoArray[indexPath.row].musicInfo?.mediaUrl?.components(separatedBy: "?v=").last!{
                    UIViewController.fetchYouTubeVideoInfo(with: cell.itemDescriptionLabel, imageYouTube: cell.videoInfoImageView, youTubeId: youTubeId)
                    }
        
                case 1:
                    cell.itemNameLabel.text = movieInfoArray[indexPath.row].movieInfo?.movieName
                    cell.itemDescriptionLabel.text =  movieInfoArray[indexPath.row].movieInfo?.director
                    if  let youTubeId = movieInfoArray[indexPath.row].movieInfo?.movieLink?.components(separatedBy: "?v=").last!{
                        UIViewController.fetchYouTubeVideoInfo(with: cell.itemDescriptionLabel, imageYouTube: cell.videoInfoImageView, youTubeId: youTubeId)
                    }
        
                case 2:
                    cell.itemNameLabel.text = sermonInfoArray[indexPath.row].sermonInfo?.sermonTitle
                    cell.itemDescriptionLabel.text = sermonInfoArray[indexPath.row].sermonInfo?.pastorName
                    if  let youTubeId = sermonInfoArray[indexPath.row].sermonInfo?.mediaUrl?.components(separatedBy: "?v=").last!{
                        UIViewController.fetchYouTubeVideoInfo(with: cell.itemDescriptionLabel, imageYouTube: cell.videoInfoImageView, youTubeId: youTubeId)
                    }
        
                case 3:
                    
                    cell.itemNameLabel.text = bookInfoArray[indexPath.row].bookInfo?.bookName
                    cell.itemDescriptionLabel.text = bookInfoArray[indexPath.row].bookInfo?.authorName
                    if  let youTubeId = bookInfoArray[indexPath.row].bookInfo?.bookMediaUrl?.components(separatedBy: "?v=").last!{
                        UIViewController.fetchYouTubeVideoInfo(with: cell.itemDescriptionLabel, imageYouTube: cell.videoInfoImageView, youTubeId: youTubeId)
                    }
        
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
        let widthView = collectionView.bounds.width
        let widthCell = (widthView / 2) - (0.03 * widthView)
        //let heightCell = widthCell * 0.7
        let heightForItem = heightView * 0.9
        let heightBook = heightView
        let widthBook = heightView * 0.7
        
    
        
        return CGSize(width: widthCell, height: heightForItem)

    }
    
}
