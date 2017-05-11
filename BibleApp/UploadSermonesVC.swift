//
//  UploadSermonesVC.swift
//  BibleApp
//
//  Created by Mac on 5/9/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class UploadSermonesVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }


}
