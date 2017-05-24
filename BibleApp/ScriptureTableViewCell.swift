//
//  ScriptureTableViewCell.swift
//  BibleApp
//
//  Created by Ostap Romaniv on 4/20/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class ScriptureTableViewCell: UITableViewCell {

    @IBOutlet weak var scriptureText: UILabel!
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var mediaWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var mediaView: UIView!
    
    var flag = true
    var mediaType = "music"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        // this is just for test, later we'll pass flag and media type dynamically
        if self.flag {
            var image = UIImage()
            self.mediaWidthConstraint.constant = 22
            
            switch mediaType {
            case "music":
                image = UIImage(named: "music")!
            case "sermon":
                image = UIImage(named: "sermon")!
            case "movie":
                image = UIImage(named: "movie")!
            case "book":
                image = UIImage(named: "book")!
            default:
                break
            }
            
            let imageView: UIImageView? = UIImageView(image: image)
            imageView?.layer.frame.size.height = self.mediaView.layer.frame.height
            imageView?.layer.frame.size.width = 22
            
            if let imgVw = imageView {
                UIView.animate(withDuration: 0.5, delay: 3, options: .curveEaseIn, animations: {
                    self.mediaView.addSubview(imgVw)
                }, completion: nil)
            } else {
                let view = UIView()
                view.layer.frame.size.height = self.mediaView.layer.frame.height
                view.layer.frame.size.width = 22
                view.layer.backgroundColor = UIColor.clear.cgColor
                self.mediaView.addSubview(view)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
