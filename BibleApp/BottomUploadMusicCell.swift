//
//  BottomUploadMusicCell.swift
//  BibleApp
//
//  Created by Mac on 5/10/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class BottomUploadMusicCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var songStory: UITextField!
    @IBOutlet weak var descript: UITextView!
    @IBOutlet weak var tags: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
