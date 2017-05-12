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
    
    @IBOutlet weak var firstIndexLabel: UILabel!
    var cellIsSelected: Bool = false
    
    
    var userSelectScripture: Bool = false {
        didSet{
        //    let image = userSelectScripture ? UIImage(named: "SelectScripture") : UIImage(named: "")
          //  selectionImageView.image = image
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        firstIndexLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let image = selected ? UIImage(named: "SelectScripture") : UIImage(named: "")
          selectionImageView.image = image
        
    }

}
