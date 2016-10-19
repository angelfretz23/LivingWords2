//
//  ChapterCollectionViewCell.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/15/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit

class ChapterCollectionViewCell: UICollectionViewCell {
    
    //STEP 1- Collection View: Cv cells by default do not have a label or anything else so we need to create a custom cell. This class will hold the outlets for the views you add to your cell in storyboard. 
    
    @IBOutlet weak var chapterLabel: UILabel!
    
    
    func updateChapterLabel(chapter: Int) {
        chapterLabel.text = "/(chapter)"
    }
    

    
    
    
    
}
