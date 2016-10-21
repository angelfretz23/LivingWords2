//
//  MediaViewController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/18/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit



class MediaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mediaSegmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
//        //
//        //add the content of the nib file into this view, owner is viewcontroller, cast last object as settingsview
//        settings = Bundle.main.loadNibNamed("Settings", owner: self, options: nil)?.last as? SettingsView
//       //give this a frame, x position of 0 and y position will be height of view controller's view plus the height we want to see on the screen 
//        settings.frame = CGRect(x: 0, y: (self.view.frame.size.height + 66), width: self.view.frame.size.width, height: self.view.frame.size.height)
//        //add it as a subview to viewcontroller
//        self.view.addSubview(settings)
//        
        
        //check sermon API fetch 
        SermonController.fetchSermon(bookName: "MAT", chapterNumber: 1, verseNumber: 12) { (sermons) in
            
        }
            
            
            
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sermonTableCell")
        return cell!
    }
    

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}


