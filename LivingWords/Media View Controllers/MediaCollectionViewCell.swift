//
//  MediaCollectionViewCell.swift
//  LivingWords
//
//  Created by Chandi Abey  on 11/26/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell {
    


    @IBOutlet weak var youtubePlayer: YTPlayerView!

    @IBOutlet weak var songNameLabel: UILabel!
    
    
    @IBOutlet weak var songArtistLabel: UILabel!

    
    func updateVideoCell(songName: String, songArtist: String)
    {
        songNameLabel.text = songName
        songArtistLabel.text = songArtist 
        
    }
    
}
