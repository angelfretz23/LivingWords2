//
//  MusicController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 1/5/17.
//  Copyright © 2017 Chandi Abey . All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class MusicController
{
    
    static let sharedController = MusicController()
    
    var verseMusicArray: [Music] = [] {
        didSet {
            let notification = Notification(name: Notification.Name(rawValue: "VideosHasChanged"))
            NotificationCenter.default.post(name: notification.name, object: nil)
        }
    }
    
    
    
    func fetchVideoIdFromFireBase(bookName: String, chapter: String, verseNumber: String) {
        //establishes a connection to Firebase database using the provided path. In firebase documentation, Firebase properties are referred to as references because they refer to a location in your Firebase database. This property allows for saving and syncing data to the given lcoation.
        let ref = FIRDatabase.database().reference()
        //using URL, you can create a reference to a child location in your Firebase database, use child to create a child reference by passing the child path
        let bookRef = ref.child(bookName)
        let chapterRef = bookRef.child("Chapter \(chapter)")
        let verseRef = chapterRef.child("Verse \(verseNumber)")
        
        
        //attach a listener to receive updates whenever the endpoint verseRef is modified, function takees two parameters, an instance of FIRDataEventType (event type specifies what event you want to listen for) and a closure
        verseRef.observe(.childAdded, with: { (snapshot) in

            //store the latest version of the data in a local variable inside the listener's closure
    
            //listner's closure returns a snapshot of the latest set of data. The snapshot returns the entire list of music items, not just the updates. Using children, you loop through the videos.
            for item in snapshot.children {
                let musicVideo = Music(snapshot: item as! FIRDataSnapshot)
                self.verseMusicArray.append(musicVideo)
                YouTubeVideoController.sharedController.fetchYouTubeVideo(id: musicVideo.youTubeVideoId, completion: { (newVideos: YouTube?) in
                    guard let newVideos = newVideos else { return }
                    YouTubeVideoController.sharedController.selectedVideos.append(newVideos)
                })
            }
        })
    }
}
