//
//  CustomTextField.swift
//  BibleApp
//
//  Created by Igor Makara on 4/25/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override func deleteBackward() {
        super.deleteBackward()
        NotificationCenter.default.post(name: Notification.Name("UserPressedClearButton"), object: nil)
    }

}
