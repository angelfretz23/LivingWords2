//
//  MediaViewController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/18/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit
import FirebaseDatabase

class MediaViewController: UIViewController {

    
    var selectedScripture: [Music] = [] {
        didSet {
            self.mediaCollectionView.reloadData()
        }
    }
    

    
    
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    @IBOutlet private weak var slider: UISlider!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mediaSegmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaSegmentedControl.removeBorders()
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "VideosHasChanged"), object: nil, queue: nil) { (notification) in
            self.reloadCollectionView()
        }
        
        
       
        // Do any additional setup after loading the view.
        //self.tableView.delegate = self
        //self.tableView.dataSource = self
        
        //check sermon API fetch 
        //SermonController.fetchSermon(bookName: "MAT", chapterNumber: 1, verseNumber: 12) { (sermons) in
        //}
        //YouTubeVideoController.fetchYouTubeVideo(id: "XG347euXoTM") { (_: [YouTube?]) in
            
        }
        
//        NotificationCenter.default.addObserver(self, selector: #selector(updateCollectionView), name: Notification.Name(rawValue: "ScriptureHasChanged"), object: nil)

    
    
    
    //create a handle to the interactor
    var interactor: Interactor? = nil
    


        
        
    func reloadCollectionView()
    {
        mediaCollectionView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sermonTableCell")
        return cell!
    }
    

    var bottomBorder = CALayer()
    
    func setupBorder() {
        //Remove SuperLayer when segment is selected
        self.bottomBorder.removeFromSuperlayer()
        // Creating new layer for selection
        self.bottomBorder = CALayer()
        self.bottomBorder.borderColor = UIColor.brown.cgColor
        self.bottomBorder.borderWidth = 6
        // Calculating frame
        let width: CGFloat = self.mediaSegmentedControl.frame.size.width / 2
        let x: CGFloat = CGFloat(self.mediaSegmentedControl.selectedSegmentIndex)
            * width
        let y: CGFloat = self.mediaSegmentedControl.frame.size.height - self.bottomBorder.borderWidth
        self.bottomBorder.frame = CGRect(x: x, y: y, width: width, height: self.bottomBorder.borderWidth)
        // Adding selection to segment
        self.mediaSegmentedControl.layer.addSublayer(self.bottomBorder)
        
    }
}


extension MediaViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    
    //also enter this string as the cell identifier in storyboard

    
    //tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return MusicController.sharedController.verseMusicArray.count
    }
    
    //make a cell for each cell index path 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        //get a reference to storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCollectionViewCell
        
        let musicVideo = MusicController.sharedController.verseMusicArray[indexPath.item]
        cell.youtubePlayer.load(withVideoId: musicVideo.youTubeVideoId, playerVars: [ "playsinline" : 1 ])
        cell.youtubePlayer.webView?.allowsInlineMediaPlayback = true
        cell.youtubePlayer.playVideo()
        cell.youtubePlayer.webView?.allowsInlineMediaPlayback = true
        let songName = musicVideo.songName
        let songArtist = musicVideo.artistName
        cell.updateVideoCell(songName: songName, songArtist: songArtist)
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        //handle tap events
//        print("im supposed to print")
//        let cell = collectionView.cellForItem(at: indexPath) as? MediaCollectionViewCell
//        cell?.youtubePlayer.webView?.allowsInlineMediaPlayback = true
//        
//    }
    
    
}




//extension MediaViewController : UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ sizeForItemAtcollectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemsPerRow:CGFloat = 10
//        let hardCodedPadding:CGFloat = 5
//        let itemWidth = (sizeForItemAtcollectionView.bounds.width / itemsPerRow) - hardCodedPadding
//        let itemHeight = sizeForItemAtcollectionView.bounds.height - (2 * hardCodedPadding)
//        return CGSize(width: itemWidth, height: itemHeight)
//    }
//    
//}



extension UISegmentedControl {
    func removeBorders() {
        setBackgroundImage(imageWithColor(color: UIColor.clear), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: UIColor.clear), for: .selected, barMetrics: .default)
        setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 2.0, height: 44.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
    
    
    
    
    func setFontSize(fontSize: CGFloat) {
        
        let normalTextAttributes: [String : AnyObject] = [
            NSForegroundColorAttributeName: UIColor.brown,
            NSFontAttributeName: UIFont.systemFont(ofSize: fontSize, weight: UIFontWeightMedium)
        ]
        
        let boldTextAttributes: [String : AnyObject] = [
            NSForegroundColorAttributeName : UIColor.brown,
            NSFontAttributeName : UIFont.systemFont(ofSize: fontSize, weight: UIFontWeightBold),
            ]
        
        self.setTitleTextAttributes(normalTextAttributes, for: .normal)
        self.setTitleTextAttributes(normalTextAttributes, for: .highlighted)
        self.setTitleTextAttributes(boldTextAttributes, for: .selected)
    }
    
    
}


