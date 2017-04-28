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
    
    // MARK:- Properties
    let labels = [MediaModel(title: "Movies", items: [MediaModelCell(imagePath: "", title: "Chris Tomlin - I Will Follow", titleBotton: ""),
                                                      MediaModelCell(imagePath: "", title: "MercyMe - I Can Only Imagine", titleBotton: ""),
                                                      MediaModelCell(imagePath: "", title: "Momentum Through Hearing God", titleBotton: "")
                    ], typeOfMedia: .Other),
                  MediaModel(title: "Sermous", items: [MediaModelCell(imagePath: "", title: "Chris Tomlin - I Will Follow", titleBotton: ""),
                                                      MediaModelCell(imagePath: "", title: "MercyMe - I Can Only Imagine", titleBotton: ""),
                                                      MediaModelCell(imagePath: "", title: "Momentum Through Hearing God", titleBotton: "")
                    ], typeOfMedia: .Other),
                  MediaModel(title: "Music", items: [MediaModelCell(imagePath: "", title: "Chris Tomlin - I Will Follow", titleBotton: ""),
                                                      MediaModelCell(imagePath: "", title: "MercyMe - I Can Only Imagine", titleBotton: ""),
                                                      MediaModelCell(imagePath: "", title: "Momentum Through Hearing God", titleBotton: "")
                    ], typeOfMedia: .Other),
                  MediaModel(title: "Books", items: [MediaModelCell(imagePath: "", title: "I Will Follow", titleBotton: "Ivan"),
                                                     MediaModelCell(imagePath: "", title: "I Can Only Imagine", titleBotton: "Orest"),
                                                     MediaModelCell(imagePath: "", title: "Momentum", titleBotton: "Nazar"),
                                                     MediaModelCell(imagePath: "", title: "I Will Follow", titleBotton: "Ivan"),
                                                     MediaModelCell(imagePath: "", title: "I Can Only Imagine", titleBotton: "Orest"),
                                                     MediaModelCell(imagePath: "", title: "Momentum", titleBotton: "Nazar")
                    ], typeOfMedia: .Book),
                  MediaModel(title: "Ivan", items: [MediaModelCell(imagePath: "", title: "Dota", titleBotton: "Easy Katka"),
                                                       MediaModelCell(imagePath: "", title: "Perfect World", titleBotton: "I am lox"),
                                                       MediaModelCell(imagePath: "", title: "HeartSrone", titleBotton: "I am lox too")
                    ], typeOfMedia: .Book),
                  MediaModel(title: "Orest", items: [MediaModelCell(imagePath: "", title: "Breaking Bad", titleBotton: "Vince Giligan"),
                                                    MediaModelCell(imagePath: "", title: "Game of Thrones", titleBotton: "Gorge Martin"),
                                                    MediaModelCell(imagePath: "", title: "Fargo", titleBotton: "Cool TV")
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
        if YTFPlayer.isOpen() && (UIDevice.current.orientation == .landscapeLeft){
            
            let controller = YTFPlayer.getYTFViewController() as! YTFViewController
            controller.expandViews()
            controller.setPlayerToFullscreen()
            
            let value = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        }
        
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
