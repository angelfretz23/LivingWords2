//
//  NewPasswordViewController.swift
//  BibleApp
//
//  Created by Ostap Romaniv on 4/27/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var newPasswordTxtFld: UITextField!
    @IBOutlet weak var confirmNewPasswordTxtFld: UITextField!
    @IBOutlet weak var blurEffectView: UIView!
    @IBOutlet weak var createNewPassword: RoundedButton!
    
    // MARK: - Properties
    var userData: User?
    var userID: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // styling
        setUpBlurEffect()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func createNewPasswordPressed(_ sender: UIButton) {
        self.displayAlert(userMessage: "You've just creted a new password!")
        
        self.performSegue(withIdentifier: "MainStoryboardPushSegueID", sender: self)
        
        if newPasswordTxtFld.text == confirmNewPasswordTxtFld.text {
            if let id = userID, let password = newPasswordTxtFld.text {
                User.confirmNewPassword(id: id, password: password, completion : { userInfo, error in
//                    if let user = userInfo {
//                        self.userData = user
//                    } else {
//                        self.displayAlert(userMessage: "Something went wrong!")
//                    }
                })
            }
        } else {
            
            self.displayAlert(userMessage: "The passwords do not match! Try again!")
            
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

extension NewPasswordViewController {
    
    fileprivate func setUpBlurEffect() {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = self.blurEffectView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.blurEffectView.addSubview(blurEffectView)
    }
    
    fileprivate func displayAlert(userMessage: String) {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(okAction)

        self.present(alert, animated: true, completion: nil)
    }
}
