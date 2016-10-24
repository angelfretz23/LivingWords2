//
//  MediaViewController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/18/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit


/*presented with a modal Presentation Style if UIModalPresentationOverFullScreen rather than default UIModalPresentationFullScreen (configured on storyboard).

 when a fullscreen view controller is presented, the corresponding presntation controller's shouldRemovePresentersView returns YES, the presentation Controller tempoarily relocates the presenting view controller's view to the presentation controller's containerView. 
 
 when the fullscreen view controller is dismissed, the presentation controller places the presenting view controller's view back in its previous superview. 
 
 the relocation of the presenting view controller's view poses a problem in this example because only the presenting view controller's view is relocated, not the intermedicate view hierarchy we setup to apply the rounded corner and shadow effect. The UIModalPresentationOverFullScreen presentation style, the presentation controller overrides shouldRemovePresentersView to NO.
 
 
 
*/



class MediaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet private weak var slider: UISlider!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mediaSegmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
    
        
        
        //
        
     
     

        
        //check sermon API fetch 
        SermonController.fetchSermon(bookName: "MAT", chapterNumber: 1, verseNumber: 12) { (sermons) in
            
        }
            
            
            
    }
    

    func updatePreferredCOntentSizeWithTraitCollection(traitCollection: UITraitCollection)
    {
        self.preferredContentSize = CGSize(width: self.view.bounds.size.width, height: traitCollection.verticalSizeClass == .compact ? 270: 350)
        

    
        //to demonstrate how a presentation controller can dynamically respond to changes to its presented view controller's preferredContentSize, this view controller exposes a slider. Dragging this slider updates the preferredContentSize of this view controller in real time. Update the slider with appropriate min/max values and reset the current value to reflect the changed preferredContentSize 
        
        self.slider.maximumValue = Float(self.preferredContentSize.height)
        self.slider.minimumValue = 220.0
        self.slider.value = self.slider.maximumValue 
        
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


