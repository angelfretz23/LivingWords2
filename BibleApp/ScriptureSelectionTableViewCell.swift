//
//  ScriptureSelectionTableViewCell.swift
//  BibleApp
//
//  Created by Oleh on 5/11/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class ScriptureSelectionTableViewCell: UITableViewCell {


    @IBOutlet weak var selectionImageView: UIImageView!
    @IBOutlet weak var scriptureLabel: UILabel!
    
    var userSelectScripture: Bool = false {
        didSet{
            let image = userSelectScripture ? UIImage(named: "SelectScripture") : UIImage(named: "")
            selectionImageView.image = image
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
