//
//  MediaTableViewCell.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/18/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit

class MediaTableViewCell: UITableViewCell {

    
        
        //add refernce to its collection view,  marked as private b/c our VC should not be accessing the collection view through the table view cell
        @IBOutlet weak var collectionView: UICollectionView!
        
        
        
        //add a function to set the delegate, datasource and row number on collectionView
        //D type conforms to both data source and delegate protocols
        
        
        //tag property is necessary because we have 1 VC and may have many collection views and need a way to distinbuish between collection views. Use the row property
        
        func setCollectionViewDataSourceDelegate <D: protocol<UICollectionViewDataSource,  UICollectionViewDelegate>>(dataSourceDelegate: D, forRow row: Int)
        {
            collectionView.delegate = dataSourceDelegate
            collectionView.dataSource = dataSourceDelegate
            collectionView.tag = row
            collectionView.reloadData()
        }
        
        
        
        
        
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            // Configure the view for the selected state
        }
        
}
