//
//  ConstantsExtentions.swift
//  BibleApp
//
//  Created by Mac on 5/17/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import Foundation
import UIKit

var isUserLogenIn = false
let isUserLogenInKey = "isUserLogenIn"

var userContentType: String?
let userContentTypeKey = "userContentType"

var userEmail = "None"
let userEmailKey = "userEmail"

var userID: Int?
let userIDKey = "userID"

var userToken: String?
let userTokenID = "userToken"

public enum ContentProviderType {
    case User
    case Pastor
    case Artist
    case Author_Book
    case Author_Movie
}

extension UIViewController {
    
    private static var is_YouTubeLoaded = false
    var isYouTubeLoaded: Bool {
        get { return UIViewController.is_YouTubeLoaded }
        set { UIViewController.is_YouTubeLoaded = newValue }
    }
    
    private static var youTube_id: String? = "-5vv7pvQXaY"
    var youTubeId: String? {
        get { return UIViewController.youTube_id }
        set { UIViewController.youTube_id = newValue}
    }
    
    private static var video_URL: String? = "default"
    var videoUrl: String? {
        get { return UIViewController.video_URL }
        set { UIViewController.video_URL = newValue}
    }
    
    private static var scripture_ID_Array: [Int]? = [0]
    
    var scriptureIDArray: [Int]? {
        get { return UIViewController.scripture_ID_Array }
        set { UIViewController.scripture_ID_Array = newValue}
    }
    
    public static func fetchYouTubeVideoInfo(with textField: UILabel, imageYouTube: UIImageView, youTubeId: String) {
        
        // request image of a particular video
        let youTubeUtlImage = "https://img.youtube.com/vi/\(youTubeId)/maxresdefault.jpg"
        URLSession.shared.dataTask(with: URL(string: youTubeUtlImage)!, completionHandler: { (data, responce, error) in
            
            DispatchQueue.main.async {
                imageYouTube.image = UIImage(data: data!)
            }
        }).resume()
        
        // request video details
        let videoInfoPath = "http://www.youtube.com/oembed?url=http%3A//www.youtube.com/watch?v=\(youTubeId)&format=json"
        URLSession.shared.dataTask(with: URL(string: videoInfoPath)!, completionHandler: { (data, responce, error) in
            
            let jsonFormat = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
            
            if let json = jsonFormat {
                DispatchQueue.main.async {
                    textField.text = json["title"] as? String
                }
            }
            
        }).resume()
    }
    
    public func loadLink(with urlString: String, contentProvider: ContentProviderType) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "LinkViewControllerID") as! LinkViewController
        controller.backController = self
        controller.pathWebView = urlString
        controller.typeContentProvider = contentProvider
        present(controller, animated: true, completion: nil)
    }
    
    public func uploadTagScriptures(content_provider: ContentProviderType) {
        
        let storyBoard = UIStoryboard(name: "BookUpload", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "ScriptureSelectionViewControllerID") as! ScriptureSelectionViewController
        controller.backController = self
        controller.contentProvider_type = content_provider
        present(controller, animated: true, completion: nil)
    }
    
    public static func cheakTypeOfMedia(media_url: String) -> MediaType {
        
        if media_url.range(of: "vimeo") != nil {
            return .vimeo
        } else if media_url.range(of: "youtube") != nil {
            return .youTube
        }
        
        return .other
    }
    
    static func configureCellImageAndTitle(media_url: String?, cell: MediaCollectionViewCell) {
        if let url_media = media_url {
            let type = UIViewController.cheakTypeOfMedia(media_url: url_media)
            
            if type == .youTube {
                let youTubeId = url_media.components(separatedBy: "?v=").last!
                UIViewController.fetchYouTubeVideoInfo(with: cell.title, imageYouTube: cell.image, youTubeId: youTubeId)
            }
        }
    }
}
