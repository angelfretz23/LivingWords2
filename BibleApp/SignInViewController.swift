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
    
    var userInfo: User?
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signInbyEmail: UIButton!
    @IBOutlet weak var googleSignIn: UIButton!
    @IBOutlet weak var facebookSignIn: RoundedButton!
    
    @IBOutlet weak var bluerEffectView: UIView!
    @IBOutlet weak var underlinedView: UIView!
    @IBOutlet var underlinedViewAllignCenterToSignUpButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpWithEmailView: UIView!
    
    @IBOutlet weak var signUpViewLeadings: NSLayoutConstraint!
    @IBOutlet weak var signUpViewTrailings: NSLayoutConstraint!
    
    @IBOutlet weak var loginInViewTrailings: NSLayoutConstraint!
    @IBOutlet weak var loginInViewLeadings: NSLayoutConstraint!
    
    // MARK: - Properties
    
    let googleLoginButton: GIDSignInButton = {
        let button = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        return button
    }()
    
    let facebookLoginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        return button
    }()
    
    // MARK: - Sign In view controller`s life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configuration for login systems
        facebookLoginButton.delegate = self
        googleSingInConfiguration()
        
        //
        setUpBlurEffect()
        signUpWithEmailView.isHidden = true
        
        // init values for constraints
        signUpViewLeadings.constant = view.frame.width
        signUpViewTrailings.constant = -view.frame.width
    }
    
    // MARK: - Actions
    
    func loginWithEmail(){
        
        User.login(withEmail:  "", password:  "", completion: {userInfo, error in
            
            if let user = userInfo {
                self.userInfo = user
                
            } else {
                
                
            }
        })
    }
    
    // actually it is 'Sign Up'
    @IBAction func loginButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.allowAnimatedContent], animations: {
            self.underlinedViewAllignCenterToSignUpButtonConstraint.priority = 20
            
            self.loginInViewLeadings.constant = -self.view.frame.width
            self.loginInViewTrailings.constant = self.view.frame.width * 2
            
            self.signUpViewTrailings.constant = 0
            self.signUpViewLeadings.constant = 0
            
            self.view.layoutIfNeeded()
        }, completion: nil)
        loginWithEmail()
    }
    
    // actually it is 'Log In'
    @IBAction func signUpButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [.allowAnimatedContent], animations: {
            self.underlinedViewAllignCenterToSignUpButtonConstraint.priority = 998
            
            self.loginInViewLeadings.constant = 0
            self.loginInViewTrailings.constant = 0
            
            self.signUpViewLeadings.constant = self.view.frame.width
            self.signUpViewTrailings.constant = -self.view.frame.width
            
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func signUpbyEmailAction(_ sender: UIButton) {
        signUpWithEmailView.isHidden = signUpWithEmailView.isHidden ? false : true
        
    }
    
    @IBAction func facebookSignInAction(_ sender: UIButton) {
        facebookLoginButton.sendActions(for: .touchUpInside)
    }
    
    @IBAction func googleSignInAction(_ sender: UIButton) {
        googleLoginButton.sendActions(for: .touchUpInside)
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
        
        if let userEmail = user?.profile.email {
            print("📧 \(userEmail)")
        }

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
        
        // set google login delegates
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
    }
    
    
    fileprivate func setUpBlurEffect(){
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = bluerEffectView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        bluerEffectView.addSubview(blurEffectView)
    }
}
