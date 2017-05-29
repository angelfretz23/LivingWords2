//
//  ScriptureTableViewCell.swift
//  BibleApp
//
//  Created by Ostap Romaniv on 4/20/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class ScriptureTableViewCell: UITableViewCell {

    @IBOutlet weak var scriptureText: UILabel?
    @IBOutlet weak var labelOne: UILabel?
    @IBOutlet weak var mediaWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var mediaView: UIView?
    @IBOutlet weak var scriptureImageView: UIImageView?

    var mediaType = ScripureMediaType.book_sermone_music_movie
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setScriptureImage(with type: String) {
        var image: UIImage
        
        switch type {
        case "book":
            image = #imageLiteral(resourceName: "book-1")
        case "book_sermon":
            image = UIImage()
        case "book_sermon_movie":
            image = UIImage()
        case "book_sermon_movie_music":
            image = #imageLiteral(resourceName: "book_movie_music_sermones")
        case "sermon_movie_music":
            image = #imageLiteral(resourceName: "musicSermonMovies")
        case "movie_music":
            image = UIImage()
        case "sermon_music":
            image = UIImage()
        case "book_music":
            image = UIImage()
        case "sermon_movie":
            image = UIImage()
        case "book_movie":
            image = UIImage()
        case "sermon":
            image = #imageLiteral(resourceName: "bible-300")
        case "movie":
            image = #imageLiteral(resourceName: "movie-1")
        case "music":
            image = #imageLiteral(resourceName: "music-1")
        default:
            image = UIImage()
        }
        
        scriptureImageView?.image = image
    }
}
