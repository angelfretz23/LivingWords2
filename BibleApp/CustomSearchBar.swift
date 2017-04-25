//
//  CustomSearchBar.swift
//  BibleApp
//
//  Created by Igor Makara on 4/25/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureAppearance()
        
    }
}

private extension CustomSearchBar {
    func configureAppearance() {

        
        for subView in subviews {
            for subsubView in subView.subviews {
                if let textField = subsubView as? UITextField {
                    
                    let color = UIColor.init(red: 210/255, green: 210/255, blue: 210/255, alpha: 0.5)
                    
                    let myAttribute1 = [ NSBackgroundColorAttributeName: color ]
                    let myAttrString1 = NSAttributedString(string: "Book", attributes: myAttribute1)
                    
                    let myAttribute2 = [ NSBackgroundColorAttributeName: color ]
                    let myAttrString2 = NSAttributedString(string: "Chapter", attributes: myAttribute2)
                    
                    let myAttribute3 = [ NSBackgroundColorAttributeName: color ]
                    let myAttrString3 = NSAttributedString(string: "Verse", attributes: myAttribute3)
                    
                    let attrSpace = [ NSBackgroundColorAttributeName: UIColor.white ]
                    let myattrSpace = NSAttributedString(string: " ", attributes: attrSpace)
                    
                    let attrDoublePoint = [ NSBackgroundColorAttributeName: UIColor.white ]
                    let myattrDoublePoint = NSAttributedString(string: ":", attributes: attrDoublePoint)
                    
                    let result = NSMutableAttributedString()
                    result.append(myAttrString1)
                    result.append(myattrSpace)
                    result.append(myAttrString2)
                    result.append(myattrDoublePoint)
                    result.append(myAttrString3)
                    
                    textField.attributedPlaceholder = result
             
                    textField.textAlignment = .left
                    
                    textField.leftViewMode = .never
                    
                    //textField.textColor = UIColor.customDarkBrownColor()
//                    textField.borderStyle = .line
//                    textField.backgroundColor = UIColor.customLightGrayColor()
//                    textField.layer.borderWidth = 1.0
//
                }
            }
        }
        
}
}
