//
//  BookTableViewCell.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/19/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var bookLabel: UILabel!
    
    //add refernce to its collection view,  marked as private b/c our VC should not be accessing the collection view through the table view cell
    @IBOutlet public weak var collectionView: UICollectionView!
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setCollectionViewDataSourceDelegate
        <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>
        (dataSourceDelegate: D, forRow row: Int)
    {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }
    
    func updateBookLabel(book: Book) {
        bookLabel.text = book.bookName
    }
    
    
}



