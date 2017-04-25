//
//  YouTubePlayerVC.swift
//  BibleApp
//
//  Created by Mac on 4/25/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit
import YouTubePlayer

class YouTubePlayerVC: UIViewController {

    @IBOutlet weak var youTubePlayer: YouTubePlayerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // youTubePlayer = YouTubePlayerView(frame: playerFrame)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playAction(_ sender: UIButton) {

        if let myVideoURL = URL(string: "https://www.youtube.com/watch?v=HUzS8-PKOsE")
        {
            youTubePlayer.loadVideoURL(myVideoURL)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
