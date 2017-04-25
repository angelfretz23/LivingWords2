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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
