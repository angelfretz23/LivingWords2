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
    
    fileprivate lazy var mediaData = [MediaModelCell]()
    fileprivate var mediaController: UIViewController?
    fileprivate var typeOfCell = MediaCellType.Other
    
    // MARK:- AllMediaTVCell`s life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    
        collectionView.register(UINib(nibName: "MediaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MediaCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

private typealias CollectionDataSource = AllMediaTVCell
extension CollectionDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCollectionViewCell
            cell.image.image = #imageLiteral(resourceName: "testImage")
            cell.title.text = mediaData[indexPath.row].title

        // if cell has books
        if mediaData[indexPath.row].titleBotton != "" && cell.titleBottom.text == "" {
            cell.titleBottom.text = mediaData[indexPath.row].titleBotton
        }
        
        cell.setNeedsLayout()
        return cell
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

        var youTubeId = "JxWfvtnHtS0"
        
        if indexPath.row == 1 {
            youTubeId = "tsFeIVJfKsA"
        }
        
        if indexPath.row == 2 {
            youTubeId = "ZcEFXDVzHYk"
        }
        
        YTFPlayer.initYTF(videoID: youTubeId)

        YTFPlayer.showYTFView(viewController: mediaController!)

    }
}

private typealias PublicMethod = AllMediaTVCell
extension PublicMethod {
    
    public func fillData(mediaData: [MediaModelCell], controller: UIViewController, type: MediaCellType) {
        self.mediaData = mediaData
        mediaController = controller
        typeOfCell = type
        
        collectionView.reloadData()
    }
}
