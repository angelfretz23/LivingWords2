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
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var signUpByEmail: UIButton!
    @IBOutlet weak var signInbyEmail: UIButton!
    @IBOutlet weak var googleSignIn: UIButton!
    @IBOutlet weak var facebookSignIn: RoundedButton!
    
    @IBOutlet weak var forgotPassword: UIButton!
    
    @IBOutlet weak var bluerEffectView: UIView!
    @IBOutlet weak var underlinedView: UIView!
    @IBOutlet var underlinedViewAllignCenterToSignUpButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpWithEmailView: UIView!
    
    @IBOutlet weak var signUpViewLeadings: NSLayoutConstraint!
    @IBOutlet weak var signUpViewTrailings: NSLayoutConstraint!
    
    @IBOutlet weak var loginInViewTrailings: NSLayoutConstraint!
    @IBOutlet weak var loginInViewLeadings: NSLayoutConstraint!
    
    
    // MARK: - Properties
    var userData: User?
    var userID: Int?
    let defaults = UserDefaults.standard
    var isUserLoginIn = true
    
    let googleLoginButton: GIDSignInButton = {
        let button = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        return button
    }()
    
    let facebookLoginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        return button
    }()
    

    // MARK: - Sign In View Controller`s life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // functions called
        
        // configuration for login systems
        facebookLoginButton.delegate = self
        googleSingInConfiguration()
        
        // styling
        setUpBlurEffect()
        styleTheButton()
        signUpWithEmailView.isHidden = true
        
        // init values for constraints
        signUpViewLeadings.constant = view.frame.width
        signUpViewTrailings.constant = -view.frame.width
    }

    
    // MARK: - IBActions
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        isUserLoginIn = false
        
        if email.text != "" && password.text != "" {
            signUpWithEmail()
            
            return
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.allowAnimatedContent], animations: {
            self.underlinedViewAllignCenterToSignUpButtonConstraint.priority = 20
            
            self.loginInViewLeadings.constant = -self.view.frame.width
            self.loginInViewTrailings.constant = self.view.frame.width * 2
            
            self.signUpViewTrailings.constant = 0
            self.signUpViewLeadings.constant = 0
            
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        //isUserLoginIn = true
        
        if email.text == "" || password.text == "" {
            
            self.displayAlert(userMessage: "Enter email adress and password to login, please")
            
        } else {
            
            enterInSystemByEmail()
        }
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "forgotPasswordID" {
            let forgotPasswordViewController = segue.destination as! ForgotPasswordViewController
            forgotPasswordViewController.userData = self.userData
            forgotPasswordViewController.userID = self.userID
        }
    }
    
}

// MARK: - Extensions
private typealias FacebookDelegate = SignInViewController
extension FacebookDelegate: FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if let token = FBSDKAccessToken.current() {
            User.loginFacebook(token: token.tokenString, completion: { (userInfo, error) in
                
                if let user = userInfo {
                    self.userData = user
                    self.loadApp()
                }
            })
        }
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
        
        User.loginGoogle(id: signIn.clientID, email: user.profile.email) { (userInfo, error) in
            
            if error != nil {
                print("Error in Google")
            }
            
            if let user = userInfo {
                self.userData = user
                self.loadApp()
            }
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
    
    
    fileprivate func setUpBlurEffect() {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = bluerEffectView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        bluerEffectView.addSubview(blurEffectView)
    }
}

private typealias TextFieldDelegate = SignInViewController
extension TextFieldDelegate: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

private typealias OtherHelpfullMethods = SignInViewController
extension OtherHelpfullMethods {
    fileprivate func enterInSystemByEmail() {
        
        User.login(withEmail: email.text!, password:  password.text! , completion: { userInfo, error in
            
            if let user = userInfo, let email = userInfo?.email  {
                self.userData = user
                self.userID = user.id
                
                //let savedToken = self.defaults.string(forKey: "userToken")
                
            
                if (email == self.email.text!) {
                    self.loadApp()
                } else {
                    self.displayAlert(userMessage: "Password or email is incorrect!!! \n Try Once More!")
                }
            } else {
                self.displayAlert(userMessage: "You need to sign up first! There was no user with such username!")
            }
        })
    }
    
    fileprivate func signUpWithEmail() {
        
        User.signUpWithEmail(email: email.text!, password: password.text!, phone: phone.text ?? "00000000", completion: { (userInfo, error) in
            if error != nil {
                print("Sign Up with email is fail")
            }
            
            if let user = userInfo, let token = userInfo?.token {
                self.userData = user
                
                
                self.defaults.set(token, forKey: "userToken")
                
                self.loadApp()
            }
        })
        
    }
    
    fileprivate func loadApp() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        
        self.show(controller, sender: self)
    }
    
    fileprivate func displayAlert(userMessage: String) {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(okAction)
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func styleTheButton() {
        self.signInbyEmail.layer.borderWidth = 1
        self.signInbyEmail.layer.borderColor = UIColor.lightGray.cgColor
        self.signUpByEmail.layer.borderWidth = 1
        self.signUpByEmail.layer.borderColor = UIColor.lightGray.cgColor
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = bluerEffectView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        
        self.signInbyEmail.addSubview(blurEffectView)
        self.signUpByEmail.addSubview(blurEffectView)
    }

}
