//
//  View.swift
//  BibleApp
//
//  Created by Angel Contreras on 9/21/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

extension UIView {
    
    func addConstraintsWith(visualFormat string: String, options: NSLayoutFormatOptions = [], views: [String: UIView]) {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: string, options: options, metrics: nil, views: views)
        addConstraints(constraints)
    }
}
