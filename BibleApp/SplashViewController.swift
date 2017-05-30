//
//  ViewController.swift
//  BibleApp
//
//  Created by Igor Makara on 4/19/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit


class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        isUserLogenIn = UserDefaults.standard.bool(forKey: isUserLogenInKey)
        userID = UserDefaults.standard.integer(forKey: userIDKey)
        
        isUserLogenIn ? performSegue(withIdentifier: "ShowAppSequeID", sender: self) :
            performSegue(withIdentifier: "ShowLoginStoryboardSegueID", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
