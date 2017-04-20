//
//  SignInViewController.swift
//  BibleApp
//
//  Created by Mac on 4/20/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class SignInViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signInbyEmail: UIButton!
    @IBOutlet weak var googleSignIn: UIButton!
    @IBOutlet weak var facebookSignIn: FBSDKLoginButton!
    
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var signUp: UIButton!

    
    // MARK: - Properties
    

    
    // MARK: - Sign In view controller`s life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookSignIn.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Actions
    
    @IBAction func signUpbyEmailAction(_ sender: UIButton) {
        facebookSignIn.publishPermissions = ["email"]
    }
    
}

private typealias FacebookDelegate = SignInViewController

extension FacebookDelegate: FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
}
