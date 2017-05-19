//
//  UploadSermonesVC.swift
//  BibleApp
//
//  Created by Mac on 5/9/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit
import Alamofire

class UploadSermonesVC: UITableViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var youTubeImage: UIImageView!
    @IBOutlet weak var vimeoImage: UIImageView!
    
    @IBOutlet weak var videoSelectedName: UILabel!
    @IBOutlet weak var videoSelectedImage: UIImageView!
    
    @IBOutlet weak var mediaURL: UILabel!
    @IBOutlet weak var scriptureTags: UITextField!
    @IBOutlet weak var pastor_name: UITextField!
    @IBOutlet weak var tags: UITextField!
    @IBOutlet weak var sermonTitle: UITextField!
    @IBOutlet weak var descript: UITextView!
    
    // MARK: - Properties
    var post: Post?

    // MARK: UploadSermonesVC`s view controller cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let panGestureYouTube = UITapGestureRecognizer(target: self, action: #selector(youTubeImageTapped(tapGestureRecognizer:)))
        youTubeImage.addGestureRecognizer(panGestureYouTube)
        youTubeImage.isUserInteractionEnabled = true
        
        let panGestureVimeo = UITapGestureRecognizer(target: self, action: #selector(vimeoImageTapped(tapGestureRecognizer:)))
        vimeoImage.addGestureRecognizer(panGestureVimeo)
        vimeoImage.isUserInteractionEnabled = true
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isYouTubeLoaded {
            fetchYouTubeVideoInfo(with: videoSelectedName, imageYouTube: videoSelectedImage, youTubeId: youTubeId!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK:- Action
    @IBAction func sharePost(_ sender: UIBarButtonItem) {
        let pastorName = self.pastor_name.text ?? ""
        let sermonTitle = self.sermonTitle.text ?? ""
        let descript = self.descript.text ?? ""
        let tags = self.tags.text ?? ""
        
        Post.uploadSermon(pastor_name: pastorName , media_url: videoUrl ?? "", sermon_title: sermonTitle, descript: descript, tags: ["#tag"], verse_id_array: scriptureIDArray ?? [0]) { (response, error) in
            if let post = response {
                self.post = post
                print("🍏 A post was shared successfully, now you see the response from server! 🍏")
            } else if error != nil {
                print("🔴 An error occured while sharing the post! 🔴")
            }
        }
          
    }
    

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    func youTubeImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        loadLink(with: "https://youtube.com", contentProvider: .Pastor)
    }
    
    func vimeoImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        loadLink(with: "https://vimeo.com", contentProvider: .Pastor)
    }
    
    @IBAction func sharedActions(_ sender: UIBarButtonItem) {
        
    }
}

extension UploadSermonesVC {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if !isYouTubeLoaded {
            if indexPath.row == 5 || indexPath.row == 6 {
                return 0
            }
        } else {
            if indexPath.row == 3 {
                return 0
            }
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 9 {
            uploadTagScriptures(content_provider: .Pastor)
        }
    }
    
    
    fileprivate func displayAlert(userMessage: String) {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
