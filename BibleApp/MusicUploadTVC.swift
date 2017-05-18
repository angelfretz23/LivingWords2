//
//  MusicUploadTVC.swift
//  BibleApp
//
//  Created by Mac on 5/10/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class MusicUploadTVC: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var textScripture: UITextView!
    @IBOutlet weak var upDownImage: UIImageView!
    @IBOutlet weak var titleScripture: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
