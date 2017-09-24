//
//  LoginSlashScreenViewController.swift
//  BibleApp
//
//  Created by Angel Contreras on 6/4/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

final class LoginSplashScreenViewController: UIViewController, UIGestureRecognizerDelegate{
    
    override func viewDidLoad() {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    internal override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @IBAction func signUpWithEmailPressed(_ sender: Any) {
        self.navigationController?.pushViewController(fetchViewControllerWithLogin(method: .registerWithEmail), animated: true)
 
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        self.navigationController?.pushViewController(fetchViewControllerWithLogin(method: .logInWithAccount), animated: true)
    }
    // TODO: Look at the old log in to get code
    @IBAction func logInWithFacebookPressed(_ sender: Any) {
    }
    
    enum LoginMethod: String{
        case registerWithEmail = "enterEmailViewController"
        case logInWithAccount = "signinViewController"
        case logInWithFacebook = ""
    }
    
    
}

fileprivate extension LoginSplashScreenViewController {
    func fetchViewControllerWithLogin(method: LoginMethod) -> UIViewController {
        let storyboard = UIStoryboard(name: "NewLogIn", bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: method.rawValue)
    }
    
}
