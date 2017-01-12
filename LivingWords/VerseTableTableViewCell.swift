//
//  VerseTableTableViewCell.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/14/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit

class VerseTableTableViewCell: UITableViewCell {

    
    
    
    
    @IBOutlet weak var verseLabel: UILabel!
    
    @IBOutlet weak var musicImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(verse: Verse) {
        if verse.verseText != "" {
            verseLabel.text = "\(verse.verseNumber) \(verse.verseText)"
        }
        musicImage.image = musicImage.image!.withRenderingMode(.alwaysTemplate)
        musicImage.tintColor = UIColor.clear
    }
   
    func updateCellWithMusicImage()
    {
        musicImage.tintColor = UIColor.purple
    }
    
    override func prepareForReuse() {
        musicImage.tintColor = UIColor.clear 
    }

}
