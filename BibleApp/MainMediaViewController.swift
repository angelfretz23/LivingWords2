//
//  MainMediaViewController.swift
//  BibleApp
//
//  Created by Mac on 4/24/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class MainMediaViewController: UIViewController {

    // MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Properties
    let labels = ["Movies", "Music", "Sermons"]
    
    // MARK:- View Controller`s life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "AllMediaTVCell", bundle: nil), forCellReuseIdentifier: "AllMediaTVCellIdentifier")
    }

}

private typealias TableViewDataSource = MainMediaViewController
extension TableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllMediaTVCellIdentifier", for: indexPath) as! AllMediaTVCell
            cell.title.text = labels[indexPath.row]

            cell.fillData(mediaData: [MediaModel(imagePath: "", title: "Chris Tomlin - I Will Follow"), MediaModel(imagePath: "", title: "MercyMe - I Can Only Imagine"), MediaModel(imagePath: "", title: "Momentum Through Hearing God") ])
        return cell
    }
}

private typealias TableDelegate = MainMediaViewController
extension TableDelegate : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 180
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
