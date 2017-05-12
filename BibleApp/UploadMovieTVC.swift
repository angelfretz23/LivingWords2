//
//  UploadMovieTVC.swift
//  BibleApp
//
//  Created by Mac on 5/12/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class UploadMovieTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
