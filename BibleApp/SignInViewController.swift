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


    @IBOutlet weak var bluerEffectView: UIView!
    @IBOutlet weak var underlinedView: UIView!
    @IBOutlet  var underlinedViewAllignCenterToSignUpButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpWithEmailView: UIView!
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
        
        
        setUpBlurEffect()
        
      
        signUpWithEmailView.isHidden = true
    }
    
    
    func setUpBlurEffect(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bluerEffectView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bluerEffectView.addSubview(blurEffectView)
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

    @IBAction func signUpByEmailButtonPressed(_ sender: Any) {
        signUpWithEmailView.isHidden = false
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
