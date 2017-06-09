//
//  LoginSlashScreenViewController.swift
//  BibleApp
//
//  Created by Angel Contreras on 6/4/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

final class LoginSplashScreenViewController: UIViewController{
    
    override func viewDidLoad() {
    }
    
    internal override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @IBAction func signUpWithEmailPressed(_ sender: Any) {
        self.present(fetchViewControllerWithLogin(method: .signUpWithEmail), animated: true, completion: nil)
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        self.present(fetchViewControllerWithLogin(method: .logInWithAccount), animated: true)
    }
    // TODO: Look at the old log in to get code
    @IBAction func logInWithFacebookPressed(_ sender: Any) {
    }
    
    enum LoginMethod: String{
        case signUpWithEmail = "singupNavigationController"
        case logInWithAccount = "signinViewController"
        case logInWithFacebook = ""
    }
    
    private func fetchViewControllerWithLogin(method: LoginMethod) -> UIViewController {
        let storyboard = UIStoryboard(name: "NewLogIn", bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: method.rawValue)
    }
}

