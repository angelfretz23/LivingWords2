//
//  NewSignInViewController.swift
//  BibleApp
//
//  Created by Angel Contreras on 9/21/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class NewSignInViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    
    //MARK: - Properties
    lazy var facebookLabel: FacebookButton = {
        let fl = FacebookButton()
        fl.setLabel(with: "SignIn/Register with Facebook")
        fl.translatesAutoresizingMaskIntoConstraints = false
        fl.delegate = self
        return fl
    }()
    
    var pushedFromRegisterFlow: Bool = false
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        setupFacebookLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    //MARK: - Methods
    private func setupFacebookLabel() {
        view.addSubview(facebookLabel)
        
        let views: [String: UIView] = ["v0": stackView, "v1": facebookLabel]
        view.addConstraintsWith(visualFormat: "H:[v1(>=20)]", views: views)
        view.addConstraintsWith(visualFormat: "V:[v0]-30-[v1(20)]", views: views)
        view.addConstraint(NSLayoutConstraint(item: facebookLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
    }
    
    
    //MARK: - Actions
    @IBAction func loginButtonPressed(_ sender: Any) {
    }
    
    @IBAction func resetPasswordPressed(_ sender: Any) {
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        if pushedFromRegisterFlow {
            self.navigationController?.popViewController(animated: true)
        } else {
            let registerVC = UIStoryboard.init(name: "NewLogIn", bundle: nil).instantiateViewController(withIdentifier: "enterEmailViewController") as! EmailRegisterViewController
            registerVC.pushedFromSignInVC = true
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
    }
}

//MARK: - Facebook Button Delegate
extension NewSignInViewController: FacebookButtonDelegate{
    func facebookButtonPressed() {
        // Do the facebook log in here
    }
}
