//
//  TopCellUploadMusicCell.swift
//  BibleApp
//
//  Created by Mac on 5/10/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class TopCellUploadMusicCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var artistName: UITextField!
    @IBOutlet weak var writerName: UITextField!
    @IBOutlet weak var mediaURL: UILabel!
    @IBOutlet weak var tagScriptures: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
