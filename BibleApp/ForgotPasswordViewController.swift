//
//  ForgotPasswordViewController.swift
//  BibleApp
//
//  Created by Ostap Romaniv on 4/25/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var blurEffectView: UIView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirmEmail: RoundedButton!
    @IBOutlet weak var checkPassCode: RoundedButton!
    @IBOutlet weak var confirmEmailView: UIView!
    
    @IBOutlet weak var confirmEmailTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var confirmEmailLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var checkPassCodeTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var checkPassCodeLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var checkPassCodeTxtFld_1: RoundedTextField!
    @IBOutlet weak var checkPassCodeTxtFld_2: RoundedTextField!
    @IBOutlet weak var checkPassCodeTxtFld_3: RoundedTextField!
    @IBOutlet weak var checkPassCodeTxtFld_4: RoundedTextField!
    
    @IBOutlet weak var passCodeViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var passCodeViewLeadingConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var userData: User?
    
 
    // MARK: - ViewControllerLifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // functions called
        
        
        // styling
        setUpBlurEffect()
        
        // initial values for constraints
        initialConstraints()
        
        // initial visibility of UI objects
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - IBActions
    @IBAction func confirmEmailPressed(_ sender: UIButton) {
        
        self.displayAlert(userMessage: "The passcode was sent to you email, check it and write in!")
        
        User.confirmEmail(email: email.text!, completion : { userInfo, error in
        
            
            self.animateForgotPasswordScreen()
//            if let user = userInfo {
//                self.userData = user
//                print(self.userData?.email ?? "No email")
//                self.animateForgotPasswordScreen()
//            } else {
//                print("No response came!")
//            }
        })
    }
    
    @IBAction func checkPassCodePressed(_ sender: UIButton) {
        
        if let num1 = checkPassCodeTxtFld_1.text, let num2 = checkPassCodeTxtFld_2.text, let num3 = checkPassCodeTxtFld_3.text, let num4 = checkPassCodeTxtFld_4.text {
        User.checkThePassCode(code: Int(num1 + num2 + num3 + num4)!, completion: { userInfo, error  in
            if let user = userInfo {
                self.userData = user
            } else {
                self.displayAlert(userMessage: "Something went wrong!")
            }
        })
        } else {
            self.displayAlert(userMessage: "Enter The Confirmation Code!")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension ForgotPasswordViewController {

    fileprivate func setUpBlurEffect() {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = self.blurEffectView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.blurEffectView.addSubview(blurEffectView)
    }
    
    fileprivate func animateForgotPasswordScreen() {
        UIView.animate(withDuration: 1, delay: 0.3, options: [.allowAnimatedContent], animations: {
            
            self.confirmEmailView.isHidden = self.confirmEmailView.isHidden ? false : true
            
            self.confirmEmailLeadingConstraint.constant = -self.view.frame.width
            self.confirmEmailTrailingConstraint.constant = self.view.frame.width*2
            
            self.passCodeViewLeadingConstraint.constant = -self.view.frame.width
            self.passCodeViewTrailingConstraint.constant = self.view.frame.width*2
            
            self.checkPassCodeLeadingConstraint.constant = 57
            self.checkPassCodeTrailingConstraint.constant = 57
            
            self.passCodeViewLeadingConstraint.constant = 0
            self.passCodeViewTrailingConstraint.constant = 0
            
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func initialConstraints() {
        checkPassCodeLeadingConstraint.constant = self.view.frame.width
        checkPassCodeTrailingConstraint.constant = -self.view.frame.width
        
        passCodeViewLeadingConstraint.constant = self.view.frame.width
        passCodeViewTrailingConstraint.constant = -self.view.frame.width
    }
    
    fileprivate func displayAlert(userMessage: String) {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(okAction)
        

        self.present(alert, animated: true, completion: nil)
    }
}
