//
//  ChapterCollectionViewCell.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/15/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit

class ChapterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var chapterLabel: UILabel!

   func updateChapterLabel(chapter: Chapter) {
        chapterLabel.text = "\(chapter.chapterNumber)"
    }

}
