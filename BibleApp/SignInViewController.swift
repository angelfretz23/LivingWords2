//
//  SignInViewController.swift
//  BibleApp
//
//  Created by Mac on 4/20/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Google
import GoogleSignIn

class SignInViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signInbyEmail: UIButton!
    @IBOutlet weak var googleSignIn: UIButton!
    @IBOutlet weak var facebookSignIn: FBSDKLoginButton!
    


    
    // MARK: - Properties
    
    let googleLoginButton: GIDSignInButton = {
        let button = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 100, height: 150))
        //button.isHidden = true
        return button
    }()
    
    // MARK: - Sign In view controller`s life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookSignIn.delegate = self
        googleSingInConfiguration()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Actions
    
    @IBAction func signUpbyEmailAction(_ sender: UIButton) {
    
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

private typealias GoogleDelegate = SignInViewController
extension GoogleDelegate: GIDSignInUIDelegate, GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("📧 \(user.profile.email)")
    }

}

private typealias ConfigurationSingInController = SignInViewController
extension ConfigurationSingInController {
    fileprivate func googleSingInConfiguration() {
        
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        
        if configureError != nil {
            print("🚨🚨🚨 Error with GGLContext")
        }
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        view.addSubview(googleLoginButton)
    }
    
}
