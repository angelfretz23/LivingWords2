//
//  File.swift
//  BibleApp
//
//  Created by Angel Contreras on 9/21/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class FacebookLabel: UIView {
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightLight)
        return label
    }()
}
