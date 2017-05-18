//
//  ProfileViewController.swift
//  BibleApp
//
//  Created by Ostap Romaniv on 5/16/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameSurname: UITextField!
    @IBOutlet weak var sermon: UITextField!
    @IBOutlet weak var descript: UITextView!
    
    @IBOutlet weak var uploadButton: UIBarButtonItem!
    
    // MARK: - Properties
    let imagePicker = UIImagePickerController()
  
    let labels = [MediaModel(title: "Music", items: [MediaModelCell(imagePath: "", title: "Home App — Welcome Home" , youtubeID: "4nbhfrQfRRE"),
                                                     MediaModelCell(imagePath: "", title: "MacBook Pro – Bulbs – Apple", youtubeID: "ROEIKn8OsGU"),
                                                     MediaModelCell(imagePath: "", title: "Apple Watch Series 2 — Go Time", youtubeID: "5t21_e7_-cQ")], typeOfMedia: .Other),
                  MediaModel(title: "Sermons", items: [MediaModelCell(imagePath: "", title: "iPhone 7 — Midnight", youtubeID: "R27KHLQ0cIU"),
                                                       MediaModelCell(imagePath: "", title: "The all-new Apple Music.", youtubeID: "CQY3KUR3VzM"),
                                                       MediaModelCell(imagePath: "", title: "Momentum Through Hearing God", youtubeID: "5t21_e7_")], typeOfMedia: .Other)
    ]

    
    // MARK: - IBActions
    
    @IBAction func uploadProfileImage(_ sender: UIButton) {
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadAction(_ sender: UIBarButtonItem) {
        
        if let type = userContentType {
            switch type {
            case "Pastor":
                performSegue(withIdentifier: "UploadSermonesID", sender: self)
            case "Author (Book)":
                performSegue(withIdentifier: "BookUploadID", sender: self)
            case "Author (Movie)":
                performSegue(withIdentifier: "UploadMoiveID", sender: self)
            case "Artist":
                performSegue(withIdentifier: "UploadMusic", sender: self)
            default:
                print("Content type of user is not found 🏵")
            }
        }
    }
    
    // MARK: - ProfileViewController`s live cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cheakContentProvider()
        // methods
        stylingFrames()
        
        // delegates
        imagePicker.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AllMediaTVCell", bundle: nil), forCellReuseIdentifier: "AllMediaTVCellIdentifier")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        let hightOther = (tableView.bounds.height) / 3
        return hightOther
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - Profile Image Picker
extension ProfileViewController {
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.profileImage.contentMode = .scaleAspectFit
        self.profileImage.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ProfileViewController {
    func stylingFrames() {
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true;
    }
    
    fileprivate func cheakContentProvider() {
        
        userContentType = UserDefaults.standard.object(forKey: userContentTypeKey) as? String
        if let contentType = userContentType {
            if contentType == "user" {
                navigationItem.rightBarButtonItem = nil
            }
        }
    }
}
