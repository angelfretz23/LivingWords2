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
        cell.youtubePlayer.load(withVideoId: MusicController.sharedController.verseMusicArray[indexPath.item].youTubeVideoId)
        cell.youtubePlayer.playVideo()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //handle tap events
    }
    
}


