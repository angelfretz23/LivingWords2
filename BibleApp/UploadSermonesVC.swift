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

    // MARK: Properties and IBOutlets
    
    @IBOutlet weak var youTubeImage: UIImageView!
    @IBOutlet weak var vimeoImage: UIImageView!
    
    @IBOutlet weak var videoSelectedName: UILabel!
    @IBOutlet weak var videoSelectedImage: UIImageView!
    
    var isYouTubeLoaded = false
    var youTubeId: String?
   
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
            fetchYouTubeVideoInfo()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Additional helpfull methods 
    
    private func fetchYouTubeVideoInfo() {
        
        // request image of a particular video
        let youTubeUtlImage = "https://img.youtube.com/vi/\(youTubeId!)/maxresdefault.jpg"
        URLSession.shared.dataTask(with: URL(string: youTubeUtlImage)!, completionHandler: { (data, responce, error) in
            
            DispatchQueue.main.async {
                self.videoSelectedImage.image = UIImage(data: data!)
            }
        }).resume()
        
        // request video getails
        let videoInfoPath = "http://www.youtube.com/oembed?url=http%3A//www.youtube.com/watch?v=\(youTubeId!)&format=json"
        URLSession.shared.dataTask(with: URL(string: videoInfoPath)!, completionHandler: { (data, responce, error) in
            
            let jsonFormat = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
            
            if let json = jsonFormat {
                DispatchQueue.main.async {
                    self.videoSelectedName.text = json["title"] as? String
                }
            }
            
            
        }).resume()
    }
    
    private func loadLink(with urlString: String) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "LinkViewControllerID") as! LinkViewController
        controller.backController = self
        controller.pathWebView = urlString
        present(controller, animated: true, completion: nil)
    }
    
    // MARK:- Action
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    func youTubeImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        loadLink(with: "https://www.youtube.com")
    }
    
    func vimeoImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        loadLink(with: "https://vimeo.com")
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
}
