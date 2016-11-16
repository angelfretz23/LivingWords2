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
        //self.tableView.delegate = self
        //self.tableView.dataSource = self
        
        //check sermon API fetch 
        SermonController.fetchSermon(bookName: "MAT", chapterNumber: 1, verseNumber: 12) { (sermons) in
        }

    }
    
    
    
    //create a handle to the interactor
    var interactor: Interactor? = nil
    
    //pan gesture has different states such as began, ended and changed. we will translate these state changes to corresponding method calls on interactor
//    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
//        
//        //sets how far up the user has to drag in order to trigger the modal presentation
//        let percentThreshold: CGFloat = 0.3
//        
//        
//        //convert y position to upward pull progress (percentage) 
//        //converts pan gesture coordinate to modal view controller's coordinate space
//        let translation = sender.translation(in: sender.view?.superview)
//        
//        //converts the vertical distance to a percentage based on the overall screen height
//        let verticalMovement = translation.y/(view.bounds.height)
//        //captures movement in upward direction. downward movement is ignored.
//        let upwardMovement = fmaxf(Float(verticalMovement), 0.0)
//        //caps percentage to a maximum of 100%
//        let upwardMovementPercent = fminf(upwardMovement, 1.0)
//        //casts the percentage as a CGFloat which is the number type that the interactor
//        let progress = CGFloat(upwardMovementPercent)
//        
//        guard let interactor = interactor else { return }
//        
//        switch sender.state {
//        case .began:
//            interactor.hasStarted = true
//            present(MediaViewController(), animated: true, completion: nil)
//        case .changed:
//            interactor.shouldFinish = progress > percentThreshold
//            interactor.update(progress)
//            
//        case.cancelled:
//            interactor.hasStarted = false
//            interactor.cancel()
//        case.ended:
//            interactor.hasStarted = false
//            interactor.shouldFinish
//               ? interactor.finish()
//               : interactor.cancel()
//        default:
//            break
//            
//        }
//        
    
        
        
//        
//        
//        
//        
//        
//        
//        
//    }

        
        

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sermonTableCell")
        return cell!
    }
    

 
   

}


