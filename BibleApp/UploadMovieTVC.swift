//
//  UploadMovieTVC.swift
//  BibleApp
//
//  Created by Mac on 5/12/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class UploadMovieTVC: UITableViewController {

    // IBOutlets and Properties
    @IBOutlet weak var director: UITextField!
    @IBOutlet weak var actors: UITextField!
    
    @IBOutlet weak var youTubeImage: UIImageView!
    @IBOutlet weak var vimeoImage: UIImageView!
    
    @IBOutlet weak var linkImage: UIImageView!
    @IBOutlet weak var linkText: UILabel!
    @IBOutlet weak var linkType: UILabel!
    
    @IBOutlet weak var tagScriptures: UITextField!
    
    @IBOutlet weak var movieName: UITextField!
    @IBOutlet weak var releseData: UITextField!
    @IBOutlet weak var synoopsis: UITextView!
    
    @IBOutlet weak var tags: UITextField!
    
    // MARK:- UploadMovieTVC`s life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
        gestureForImages()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isYouTubeLoaded {
            UIViewController.fetchYouTubeVideoInfo(with: linkText, imageYouTube: linkImage, youTubeId: youTubeId!)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK:- Actions
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareAction(_ sender: UIBarButtonItem) {
        let director = self.director.text ?? "default director"
        let actors = self.actors.text ?? "default actors"
        let link = videoUrl ?? "default link"
        let movie_name = self.movieName.text ?? "movie name default"
        let release_date = self.releseData.text ?? "default release date"
        let synoopsis = self.synoopsis.text ?? "synoopsis default"
        let tags = ["ff"]
        let verse_id_arr = scriptureIDArray ?? [0]
        
        Post.uploadMovie(director: director, actors: actors, media_url: link, verse_id_array: verse_id_arr,
                         movieName: movie_name, releaseData: release_date,
                         synoopsis: synoopsis, tags: tags) { (post, error) in
                            if error != nil{
                                print("🍎Some error occured 🍎")
                            }else {
                                print("🍏 Request is seccessfull 🍏")
                            }
        }
        
    }
    
    func youTubeImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        loadLink(with: "https://youtube.com", contentProvider: .Author_Movie)
    }
    
    func vimeoImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        loadLink(with: "https://vimeo.com", contentProvider: .Author_Movie)
    }
    
    // MARK:- Table View delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if !isYouTubeLoaded {
            if indexPath.row == 8 || indexPath.row == 7 {
                return 0
            }
        } else {
            if indexPath.row == 5 {
                return 0
            }
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 11 {
            uploadTagScriptures(content_provider: .Author_Movie)
        }
    }
    
    // MARK:- The other helpfull methods
    
    private func gestureForImages() {
        
        let panGestureYouTube = UITapGestureRecognizer(target: self, action: #selector(youTubeImageTapped(tapGestureRecognizer:)))
        youTubeImage.addGestureRecognizer(panGestureYouTube)
        youTubeImage.isUserInteractionEnabled = true
        
        let panGestureVimeo = UITapGestureRecognizer(target: self, action: #selector(vimeoImageTapped(tapGestureRecognizer:)))
        vimeoImage.addGestureRecognizer(panGestureVimeo)
        vimeoImage.isUserInteractionEnabled = true
    }
}
