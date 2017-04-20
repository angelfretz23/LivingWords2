//
//  LoginWithEmailViewController.swift
//  BibleApp
//
//  Created by Igor Makara on 4/20/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class SignUpWithEmailViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    @IBOutlet weak var bluerEffectView: UIView!
    @IBOutlet weak var underlinedView: UIView!
    @IBOutlet  var underlinedViewAllignCenterToSignUpButtonConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTextFields()
        
        setUpBlurEffect()
    }

    func setUpTextFields(){
        emailTextField.attributedPlaceholder = attributedPlaceholderText("Email")
        passwordTextField.attributedPlaceholder = attributedPlaceholderText("Password")
        mobileNumberTextField.attributedPlaceholder = attributedPlaceholderText("Mobile Number")
    }
    
    func setUpBlurEffect(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bluerEffectView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bluerEffectView.addSubview(blurEffectView)
    }
    
    func attributedPlaceholderText(_ placeHolderText: String) -> NSAttributedString {
        let attributedPlaceholderText = NSAttributedString(string: placeHolderText,
                                                           attributes: [NSForegroundColorAttributeName: UIColor.init(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)])
        return attributedPlaceholderText
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.allowAnimatedContent], animations: {
            self.underlinedViewAllignCenterToSignUpButtonConstraint.priority = 20
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [.allowAnimatedContent], animations: {
            self.underlinedViewAllignCenterToSignUpButtonConstraint.priority = 998
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
