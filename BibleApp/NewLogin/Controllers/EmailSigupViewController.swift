//
//  EmailSigupViewController.swift
//  BibleApp
//
//  Created by Angel Contreras on 6/10/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class EmailRegisterViewController: UIViewController, UIGestureRecognizerDelegate{
    
    lazy var badEmailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.text = "You have entered an invalid email address."
        return label
    }()
    
    var pushedFromSignInVC: Bool = false
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        setupBadEmailLabel()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        emailTextField.resignFirstResponder()
        guard let emailText = emailTextField.text, !emailText.isEmpty else { return }
        EmailVerifier.shared.isValid(email: emailText) { (valid) in
            if valid {
                UserLogInController.shared.userEmail = emailText
                let fullnameVC = UIStoryboard(name: "NewLogIn", bundle: nil).instantiateViewController(withIdentifier: "enterFullNameController")
                self.navigationController?.pushViewController(fullnameVC, animated: true)
            } else {
                badEmailLabel.isHidden = false
            }
        }
    }
    
    @IBAction func singInButtonPressed(_ sender: Any) {
        if pushedFromSignInVC {
            self.navigationController?.popViewController(animated: true)
        } else {
            let storyboard = UIStoryboard(name: "NewLogIn", bundle: nil)
            let signInVC = storyboard.instantiateViewController(withIdentifier: "signinViewController") as! NewSignInViewController
            signInVC.pushedFromRegisterFlow =  true
            self.navigationController?.pushViewController(signInVC, animated: true)
        }
    }
    
    private func setupBadEmailLabel(){
        view.addSubview(badEmailLabel)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: [], metrics: nil, views: ["v0": badEmailLabel])
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]", options: [], metrics: nil, views: ["v0":nextButton, "v1": badEmailLabel])
        view.addConstraints(horizontalConstraints)
        view.addConstraints(verticalConstraints)
    }
}
