//
//  ProfileViewController.swift
//  BibleApp
//
//  Created by Ostap Romaniv on 5/16/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit
import SVProgressHUD

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    struct Constants {
        static let ProfileMediaTableViewCell = "ProfileMediaTableViewCell"
        static let ProfileMediaTableViewCellReuseID = "ProfileMediaTableViewCellReuseID"
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileTableView: UITableView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameSurname: UITextField!
    @IBOutlet weak var sermon: UITextField!
    @IBOutlet weak var descript: UITextView!
    
    @IBOutlet weak var uploadButton: UIBarButtonItem!
    
    //Sorting Buttons
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var myMediaButton: UIButton!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var highlightsButton: UIButton!
    @IBOutlet weak var notesButton: UIButton!
    
    var userInfoMedia: User?
    
    var buttonsArray: [UIButton?] {
        return [self.historyButton, self.myMediaButton, self.favoritesButton, self.highlightsButton, self.notesButton]
    }
    
    var mediaTypes = ["Music", "Sermons", "Video", "Books"]
    
    // MARK: - Properties
    let imagePicker = UIImagePickerController()
 
    // MARK: - IBActions
    
    @IBAction func sortingButtonPressed(_ sender: Any) {
     highLightButtons(senderTag: (sender as AnyObject).tag)
        updateDataSourceIfNeeded()
        
    }
    
    func highLightButtons(senderTag: Int){
        for index in 0...4 {
            buttonsArray[index]?.setTitleColor(UIColor.init(red: 120/255, green: 120/255, blue: 120/255, alpha: 1), for: .normal)
        }
        buttonsArray[senderTag]?.setTitleColor(.red, for: .normal)
    }
    
    
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
    var profileViewController: ProfileViewController?
    
    // MARK: - ProfileViewController`s life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cheakContentProvider()
        // methods
        stylingFrames()
        
        // delegates
        imagePicker.delegate = self
        
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
        
        registerXibs()
        
        configureTableView()
        
        buttonsArray[0]?.setTitleColor(.red, for: .normal)
        
        updateDataSourceIfNeeded()
        
        profileViewController = self
        
    }

    func registerXibs() {
        profileTableView.register(UINib(nibName: Constants.ProfileMediaTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.ProfileMediaTableViewCellReuseID)
    }
    
    func configureTableView(){
        profileTableView.rowHeight = UITableViewAutomaticDimension
        profileTableView.estimatedRowHeight = 200
    }
    
    func mediaTypesCount() -> Int{
        var count: Int = 0
        let musicCount = userInfoMedia?.musicInfoArray?.count
        let movieCount = userInfoMedia?.movieInfoArray?.count
        let sermonCount = userInfoMedia?.sermonInfoArray?.count
        let bookCount = userInfoMedia?.bookInfoArray?.count
        if musicCount != nil {
            count += 1
        }
        if movieCount != nil {
            count += 1
        }
        if sermonCount != nil {
            count += 1
        }
        if bookCount != nil {
            count += 1
        }
        print(count)
        return count
        
    }
 
    
    
    func updateDataSourceIfNeeded() {
        SVProgressHUD.show()
        SVProgressHUD.setBackgroundColor(UIColor.init(red: 195/255, green: 194/255, blue: 201/255, alpha: 1))
        fetchUserMedia { success in
            if success {
                SVProgressHUD.dismiss()
                self.profileTableView.reloadData()
                
            }
        }
    }
    
    func fetchUserMedia(completion: @escaping (_ sucess: Bool)-> Void){
        
        User.getUserInfoMedia(filterMedia: "history", userId: 6, completion:{ userMedia, error in
            if let userMedia  = userMedia {
                self.userInfoMedia = userMedia
             
                for musix in (self.userInfoMedia?.musicInfoArray)! {
                    print(musix.musicInfo?.descriptionMusic)
                }
                
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaTypesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ProfileMediaTableViewCellReuseID, for: indexPath) as! ProfileMediaTableViewCell
        
       // cell.mediaForProfileController = profileViewController
        
        if let mediaInfo = userInfoMedia {
        
        if userInfoMedia?.musicInfoArray?.count != 0 && indexPath.row == 0{
            cell.mediaTypeLabel.text = "Music"
            cell.getData(userInfo: mediaInfo.musicInfoArray, index: 0)
        }
        if userInfoMedia?.movieInfoArray?.count != 0  && indexPath.row == 1{
            cell.mediaTypeLabel.text = "Movie"
            cell.getData(userInfo: mediaInfo.movieInfoArray, index: 1)

        }
        if userInfoMedia?.sermonInfoArray?.count != 0 && indexPath.row == 2{
            cell.mediaTypeLabel.text = "Sermon"
            cell.getData(userInfo: mediaInfo.sermonInfoArray, index: 2)

        }
        if userInfoMedia?.musicInfoArray?.count != 0 && indexPath.row == 3{
            cell.mediaTypeLabel.text = "Book"
            cell.getData(userInfo: mediaInfo.bookInfoArray, index: 3)

        }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let hightOther = (tableView.bounds.height) / 2
        return hightOther
    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }
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
