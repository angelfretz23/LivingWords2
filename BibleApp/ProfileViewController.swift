//
//  ProfileViewController.swift
//  BibleApp
//
//  Created by Ostap Romaniv on 5/16/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit
import SVProgressHUD

class ProfileViewController: UIViewController {
    
    //MARK: Constants
    struct Constants {
        static let ProfileMediaTableViewCell = "ProfileMediaTableViewCell"
        static let ProfileMediaTableViewCellReuseID = "ProfileMediaTableViewCellReuseID"
        
        static let ScriptureTableViewCell = "ScriptureTableViewCell"
        static let ScriptureTableViewCellReuseID = "ScriptureCellID"
    }
    
    //MARK: Enums
    enum MediaFilter: String{
        case history = "history"
        case myMedia = "my-media"
        case favorities = "favorites"
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileTableView: UITableView!
    
    @IBOutlet weak var profileImage:    UIImageView!
    @IBOutlet weak var nameSurname:     UITextField!
    @IBOutlet weak var sermon:          UITextField!
    @IBOutlet weak var descript:        UITextView!
    @IBOutlet weak var uploadButton:    UIBarButtonItem!
    
    //Sorting Buttons
    @IBOutlet weak var historyButton:       UIButton!
    @IBOutlet weak var myMediaButton:       UIButton!
    @IBOutlet weak var favoritesButton:     UIButton!
    @IBOutlet weak var highlightsButton:    UIButton!
    @IBOutlet weak var notesButton:         UIButton!
    
    
    //MARK: Variables
    var buttonsArray: [UIButton?] {
        return [self.historyButton, self.myMediaButton, self.favoritesButton, self.highlightsButton, self.notesButton]
    }
    
    var userInfoMedia: Verse?
    
    var filterMedia: String = MediaFilter.history.rawValue
    
    var search: [Search] = []
    
    var highligtsDownload: Bool = false
    
    var profileViewController: ProfileViewController?
    
    // MARK: - IBActions
    @IBAction func sortingButtonPressed(_ sender: Any) {
        filterButtonsPressed(sender: sender as! UIButton)
    }
    
    @IBAction func uploadProfileImage(_ sender: UIButton) {
        showImagePicker()
    }
    
    @IBAction func uploadAction(_ sender: UIBarButtonItem) {
        uploadContent()
    }
    
    // MARK: - ProfileViewController`s life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cheakContentProvider()

        stylingFrames()
     
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
        profileTableView.register(UINib(nibName: "ScriptureTableViewCell", bundle: nil), forCellReuseIdentifier: "ScriptureCellID")
    }
    
    func configureTableView(){
        profileTableView.rowHeight = UITableViewAutomaticDimension
        profileTableView.estimatedRowHeight = 200
    }
    
    func filterButtonsPressed(sender: UIButton){
        highLightButtons(senderTag: (sender as AnyObject).tag)
        
        if (sender as AnyObject).tag == 3 {
            highligtsDownload = true
            
            getHighlights()
            
        }else {
            updateDataSourceIfNeeded()
        }
    }
    
    func uploadContent(){
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
    
    func setFilterString(tag: Int) -> String{
        switch tag {
        case 0:
            return MediaFilter.history.rawValue
        case 1:
            return MediaFilter.myMedia.rawValue
        case 2:
            return MediaFilter.favorities.rawValue
        case 3:
            return ""
        case 4:
            return ""
        default:
            break
        }
        return ""
    }
    
    func highLightButtons(senderTag: Int){
        for index in 0...4 {
            buttonsArray[index]?.setTitleColor(UIColor.init(red: 120/255, green: 120/255, blue: 120/255, alpha: 1), for: .normal)
        }
        
        buttonsArray[senderTag]?.setTitleColor(.red, for: .normal)
        filterMedia = setFilterString(tag: senderTag)
    }
    
    func mediaTypesCount() -> Int{
        var count: Int = 0
        let musicCount = userInfoMedia?.musicInfoArray?.count
        let movieCount = userInfoMedia?.movieInfoArray?.count
        let sermonCount = userInfoMedia?.sermonInfoArray?.count
        let bookCount = userInfoMedia?.bookInfoArray?.count
        if musicCount != nil && musicCount != 0{
            count += 1
        }
        if movieCount != nil && musicCount != 0{
            count += 1
        }
        if sermonCount != nil && musicCount != 0{
            count += 1
        }
        if bookCount != nil && musicCount != 0{
            count += 1
        }
        
        return count
    }
    
    func showImagePicker(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        imagePicker.allowsEditing = true
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if highligtsDownload {
            return search.count
        }
        return mediaTypesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !highligtsDownload {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ProfileMediaTableViewCellReuseID, for: indexPath) as! ProfileMediaTableViewCell
            
            cell.mediaForProfileController = profileViewController
            cell.getVerse(verseInfo: userInfoMedia!)
            
            if let mediaInfo = userInfoMedia {
                if userInfoMedia?.musicInfoArray?.count != 0 && indexPath.row == 0{
                    cell.mediaTypeLabel.text = "Music"
                    cell.getData(userInfo: mediaInfo.musicInfoArray, index: 0, cellType: "music")
                }
                if userInfoMedia?.movieInfoArray?.count != 0  && indexPath.row == 1{
                    cell.mediaTypeLabel.text = "Movie"
                    cell.getData(userInfo: mediaInfo.movieInfoArray, index: 1, cellType: "movie")
                    
                }
                if userInfoMedia?.sermonInfoArray?.count != 0 && indexPath.row == 2{
                    cell.mediaTypeLabel.text = "Sermon"
                    cell.getData(userInfo: mediaInfo.sermonInfoArray, index: 2, cellType: "sermon")
                    
                }
                if userInfoMedia?.musicInfoArray?.count != 0 && indexPath.row == 3{
                    cell.mediaTypeLabel.text = "Book"
                    cell.getData(userInfo: mediaInfo.bookInfoArray, index: 3, cellType: "book")
                    
                }
                
            }
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScriptureCellID", for: indexPath) as? ScriptureTableViewCell else { return  UITableViewCell() }
        var attributedScriptureText = NSMutableAttributedString()
        
        if (indexPath.row == 0) {
            cell.labelOne?.isHidden = false
            attributedScriptureText = NSMutableAttributedString(string: "\(indexPath.row + 2)" + " ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.clear])
        } else {
            cell.labelOne?.isHidden = true
            attributedScriptureText = NSMutableAttributedString(string: "\(indexPath.row + 1)" + ". ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.blue])
        }
        
        let string = " " + (search[indexPath.row].bible_book_verse?.verse)!
        attributedScriptureText.append(NSAttributedString(string:string, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.black]))
        
        cell.scriptureText?.attributedText = attributedScriptureText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let viewHeight = tableView.bounds.height
        let hightOther = (viewHeight ) / 2
        let heightBook = viewHeight * 0.3
        
        if highligtsDownload {
            return UITableViewAutomaticDimension
        }
        return hightOther
    }
    //
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 0
    //    }
}

// MARK: - Profile Image Picker
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.profileImage.contentMode = .scaleToFill
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

//Get highlights
extension ProfileViewController {
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
        Verse.getUserInfoMedia(filterMedia: filterMedia, userId: 45, completion:{ userMedia, error in
            if let userMedia  = userMedia {
                self.userInfoMedia = userMedia
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    func getHighlights() {
        SVProgressHUD.show()
        SVProgressHUD.setBackgroundColor(UIColor.init(red: 195/255, green: 194/255, blue: 201/255, alpha: 1))
        fetchHighLights { success in
            if success {
                SVProgressHUD.dismiss()
                self.profileTableView.reloadData()
                
            }
        }
    }
    private func fetchHighLights(completion: @escaping (_ sucess: Bool)-> Void){
        Search.getHighlights{searchResult, error in
            if let fetchedSearch = searchResult{
                self.search = fetchedSearch
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
