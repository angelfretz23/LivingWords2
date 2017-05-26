//
//  MainMediaViewController.swift
//  BibleApp
//
//  Created by Mac on 4/24/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class MainMediaViewController: UIViewController {

    
    // MARK:- IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var allMedia: UIButton!
    @IBOutlet weak var music: UIButton!
    @IBOutlet weak var sermones: UIButton!
    @IBOutlet weak var movies: UIButton!
    @IBOutlet weak var books: UIButton!
    
    var controllerScripture: MainTableViewController?
    var verses: Verse?
    var mediaData: [Verse]?
    
    // MARK: - IBActions
    
    @IBAction func dismissMediaView(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func MusicAction(_ sender: UIButton) {
        highlightsMedia(type: .music, allMedia: allMedia, music: music, movies: movies, sermones: sermones, books: books)
        type_media = .music
        
        collectionView.isHidden = false
        tableView.isHidden = true
        
        collectionView.reloadData()
    }
    
    @IBAction func sermoneAction(_ sender: UIButton) {
        highlightsMedia(type: .sermons, allMedia: allMedia, music: music, movies: movies, sermones: sermones, books: books)
        type_media = .sermons
        
        collectionView.isHidden = false
        tableView.isHidden = true
        
        collectionView.reloadData()
    }
    
    @IBAction func MovieAction(_ sender: UIButton) {
        highlightsMedia(type: .movies, allMedia: allMedia, music: music, movies: movies, sermones: sermones, books: books)
        type_media = .movies
        
        collectionView.isHidden = false
        tableView.isHidden = true
        
        collectionView.reloadData()
    }
    
    @IBAction func BookAction(_ sender: UIButton) {
        highlightsMedia(type: .books, allMedia: allMedia, music: music, movies: movies, sermones: sermones, books: books)
        type_media = .books
        
        collectionView.isHidden = false
        tableView.isHidden = true
        
        collectionView.reloadData()
    }
    
    @IBAction func allMediaAction(_ sender: UIButton) {
        highlightsMedia(type: .allMedia, allMedia: allMedia, music: music, movies: movies, sermones: sermones, books: books)
        type_media = .allMedia
        
        collectionView.isHidden = true
        tableView.isHidden = false
        
        collectionView.reloadData()
    }
    
    // MARK:- Properties
 
    let media = ["Movie", "Sermone", "Music", "Book"]
    var type_media = Media.allMedia
    
    // MARK:- View Controller`s life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AllMediaTVCell", bundle: nil), forCellReuseIdentifier: "AllMediaTVCellIdentifier")
        
        collectionView.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "MediaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MediaCell")
        collectionView.register(UINib(nibName: "BookTypeCollectionVCell", bundle: nil), forCellWithReuseIdentifier: "BookTypeCollectionVCellID")
    }
    

    override var shouldAutorotate: Bool {
        // FIXME: should fix it and transfer to an other views
//        if YTFPlayer.isOpen() && (UIDevice.current.orientation == .landscapeLeft){
//            
//            let controller = YTFPlayer.getYTFViewController() as! YTFViewController
//            controller.expandViews()
//            controller.setPlayerToFullscreen()
//            
//            let value = UIInterfaceOrientation.landscapeLeft.rawValue
//            UIDevice.current.setValue(value, forKey: "orientation")
//        }
        
        return false
    }

}

private typealias TableViewDataSource = MainMediaViewController
extension TableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return media.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllMediaTVCellIdentifier", for: indexPath) as! AllMediaTVCell
        
        cell.title.text = media[indexPath.row]
        
        switch media[indexPath.row] {
        case "Movie":
            cell.fillData(mediaData: verses!.movie,
                          controller: self,
                          type: .movies)
        case "Sermone":
            cell.fillData(mediaData: verses!.sermon,
                          controller: self,
                          type: .sermons)
        case "Music":
            cell.fillData(mediaData: verses!.music,
                          controller: self,
                          type: .music)
        case "Book":
            cell.fillData(mediaData: verses!.book,
                          controller: self,
                          type: .books)
        
        default:
            print("")
        }
        
        return cell
    }
}

private typealias TableDelegate = MainMediaViewController
extension TableDelegate : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let viewHeight = tableView.bounds.height
        let hightOther = (viewHeight * 0.7) / 3
        let heightBook = viewHeight * 0.3
        
        if indexPath.row == 3 {
            return heightBook
        }
        
        return hightOther
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}

private typealias CollectionDataSource = MainMediaViewController
extension CollectionDataSource : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if type_media == .books {
            if let verseCount = verses?.book?.count {
                return verseCount
            }
        }
        
        if type_media == .movies {
            
            if let verseCount = verses?.movie?.count {
                return verseCount
            }
        }
        
        if type_media == .music {
            if let verseCount = verses?.music?.count {
                return verseCount
            }
        }
        
        if type_media == .sermons {
            if let verseCount = verses?.sermon?.count {
                return verseCount
            }
        }
        
         return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if type_media == .books {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCollectionViewCell
            
            if let cellData = verses?.book?[indexPath.row] {
              //  cell.image.image = #imageLiteral(resourceName: "image-slider-2")
                UIViewController.configureCellImageAndTitle(media_url: cellData.media_url, cell: cell)
            }
            
            mediaData = verses?.book
            
            return cell
        }
        
        if type_media == .movies {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCollectionViewCell
            
            if let cellData = verses?.movie?[indexPath.row] {
                cell.image.image = #imageLiteral(resourceName: "image-slider-2")
                UIViewController.configureCellImageAndTitle(media_url: cellData.movie_link, cell: cell)
            }
            
            mediaData = verses?.movie
            
            return cell
            
        }
        
        if type_media == .music {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCollectionViewCell
            
            if let cellData = verses?.music?[indexPath.row] {
                cell.image.image = #imageLiteral(resourceName: "image-slider-2")
                UIViewController.configureCellImageAndTitle(media_url: cellData.media_url, cell: cell)
            }
            
            mediaData = verses?.music
            
            return cell
        }
        
        if type_media == .sermons {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCollectionViewCell
            
            if let cellData = verses?.sermon?[indexPath.row] {
                cell.image.image = #imageLiteral(resourceName: "image-slider-2")
                UIViewController.configureCellImageAndTitle(media_url: cellData.media_url, cell: cell)
            }
            
            mediaData = verses?.sermon
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

private typealias CollectionDelegate_and_Flov = MainMediaViewController
extension CollectionDelegate_and_Flov: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let heightView = collectionView.bounds.height
        let widthView = collectionView.bounds.width
        let widthCell = (widthView / 2) - (0.03 * widthView)
        let heightCell = widthCell * 0.7
        
        let heightBook = heightView
        let widthBook = heightView * 0.7
        
        if type_media == .books {
            return CGSize(width: widthBook, height: heightBook)
        }
        
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let edgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
        return edgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let media_url = collectionView.mediaUrlDependOnType(indexPath: indexPath, mediaData: mediaData, typeOfCell: type_media) {

            let typeOfMedia = UIViewController.cheakTypeOfMedia(media_url: media_url)
                
            YTFPlayer.initWithAVPlayer(tableViewDataSource: self as UITableViewDataSource, type: typeOfMedia, media_url: media_url)
                
            YTFPlayer.showYTFView(viewController: self)
                
            dismiss(animated: false, completion: nil)
        
        }

    }
}

