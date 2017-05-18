//
//  ContentProviderProfileVC.swift
//  BibleApp
//
//  Created by Ostap Romaniv on 5/17/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class ContentProviderProfileVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mediaButton: UIButton!
    
    
    // MARK: - Properties
    var typeOfContentOwner = "author"
    
    fileprivate let labels = [MediaModel(title: "Music", items: [MediaModelCell(imagePath: "", title: "Home App — Welcome Home", youtubeID: "4nbhfrQfRRE"), MediaModelCell(imagePath: "", title: "MacBook Pro – Bulbs – Apple", youtubeID: "ROEIKn8OsGU"),MediaModelCell(imagePath: "", title: "Apple Watch Series 2 — Go Time", youtubeID: "5t21_e7_-cQ")], typeOfMedia: .Other)]

    
    // MARK: - IBActions
    @IBAction func uploadContent(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "UploadSermonesID") as! UITableViewController
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    // MARK: - View Controller Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Methods called
        checkContentOwnerType(typeOfContentOwner)
        
        // MARK: - Delegates
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AllMediaTVCell", bundle: nil), forCellReuseIdentifier: "AllMediaTVCellIdentifier")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension ContentProviderProfileVC {
    fileprivate func checkContentOwnerType(_ typeOfContentOwner: String) {

        switch typeOfContentOwner {
        case "artist":
            mediaButton.setAttributedTitle(NSMutableAttributedString(string: "Music", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.black]), for: .normal)
        case "author":
            mediaButton.setAttributedTitle(NSMutableAttributedString(string: "Books", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.black]), for: .normal)
        case "pastor":
            mediaButton.setAttributedTitle(NSMutableAttributedString(string: "Sermons", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.black]), for: .normal)
        default:
            mediaButton.setAttributedTitle(NSMutableAttributedString(string: "Default", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.black]), for: .normal)
        }
    }
    
}

extension ContentProviderProfileVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllMediaTVCellIdentifier", for: indexPath) as! AllMediaTVCell
        
        cell.title.text = labels[indexPath.row].title
        
        cell.fillData(mediaData: labels[indexPath.row].items, controller: self, type: labels[indexPath.row].typeOfMedia)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let hightOther = (tableView.bounds.height) / 4
        return hightOther
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
