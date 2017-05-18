//
//  HomeViewController.swift
//  BibleApp
//
//  Created by ігор on 4/28/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.items![1].image = UIImage(named: "BookTabBarIcon")
        self.tabBarController?.tabBar.items![1].title = "Read"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
