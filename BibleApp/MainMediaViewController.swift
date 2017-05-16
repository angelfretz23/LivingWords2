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
    @IBOutlet weak var headerView: UIView!
    
    // MARK: - IBActions
    
    @IBAction func dismissMediaView(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK:- Properties
    let labels = [MediaModel(title: "Movies", items: [MediaModelCell(imagePath: "", title: "Home App — Welcome Home" , youtubeID: "4nbhfrQfRRE"),
                                                      MediaModelCell(imagePath: "", title: "MacBook Pro – Bulbs – Apple", youtubeID: "ROEIKn8OsGU"),
                                                      MediaModelCell(imagePath: "", title: "Apple Watch Series 2 — Go Time", youtubeID: "5t21_e7_-cQ")
                    ], typeOfMedia: .Other),
                  MediaModel(title: "Sermons", items: [MediaModelCell(imagePath: "", title: "iPhone 7 — Midnight", youtubeID: "R27KHLQ0cIU"),
                                                      MediaModelCell(imagePath: "", title: "The all-new Apple Music.", youtubeID: "CQY3KUR3VzM"),
                                                      MediaModelCell(imagePath: "", title: "Momentum Through Hearing God", youtubeID: "")
                    ], typeOfMedia: .Other),
                  MediaModel(title: "Music", items: [MediaModelCell(imagePath: "", title: "Chris Tomlin - I Will Follow", youtubeID: ""),
                                                      MediaModelCell(imagePath: "", title: "MercyMe - I Can Only Imagine", youtubeID: ""),
                                                      MediaModelCell(imagePath: "", title: "Momentum Through Hearing God", youtubeID: "")
                    ], typeOfMedia: .Other),
                  MediaModel(title: "Books", items: [MediaModelCell(imagePath: "", title: "I Will Follow", titleBotton: "Ivan"),
                                                     MediaModelCell(imagePath: "", title: "I Can Only Imagine", titleBotton: "Orest"),
                                                     MediaModelCell(imagePath: "", title: "Momentum", titleBotton: "Nazar"),
                                                     MediaModelCell(imagePath: "", title: "I Will Follow", titleBotton: "Ivan"),
                                                     MediaModelCell(imagePath: "", title: "I Can Only Imagine", titleBotton: "Orest"),
                                                     MediaModelCell(imagePath: "", title: "Momentum", titleBotton: "Nazar")
                    ], typeOfMedia: .Book)
                  ]
    
    // MARK:- View Controller`s life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AllMediaTVCell", bundle: nil), forCellReuseIdentifier: "AllMediaTVCellIdentifier")
    }
    

    override var shouldAutorotate: Bool {
        // FIXME: should fix it and transfer to an other views
//        if YTFPlayer.isOpen() && (UIDevice.current.orientation == .landscapeLeft){
//            
//            let controller = YTFPlayer.getYTFViewController() as! YTFViewController
//            controller.expandViews()
//            controller.setPlayerToFullscreen()
//            
//            let value = UIInterfaceOrientation.landscapeLeft.rawValue
//            UIDevice.current.setValue(value, forKey: "orientation")
//        }
        
        return false
    }
    
}

private typealias TableViewDataSource = MainMediaViewController
extension TableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllMediaTVCellIdentifier", for: indexPath) as! AllMediaTVCell
        
        cell.title.text = labels[indexPath.row].title
        
        cell.fillData(mediaData: labels[indexPath.row].items,
                      controller: self,
                      type: labels[indexPath.row].typeOfMedia)
        
        return cell
    }
}

private typealias TableDelegate = MainMediaViewController
extension TableDelegate : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let viewHeight = tableView.bounds.height
        let hightOther = (viewHeight * 0.7) / 3
        let heghtBook = viewHeight * 0.3
        
        if labels[indexPath.row].typeOfMedia == .Book {
            return heghtBook
        }
        
        return hightOther
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
