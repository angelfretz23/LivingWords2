//
//  ChapterContentViewController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/13/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit

//STEP 2- declare the transitioning delegate and animatedtransitioning protocols in the class definition 

class ChapterContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    //MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bookAndChapterButton: UIButton!
    @IBOutlet weak var mediaContainerView: UIView!
    
    
    
    static let storyboardIdentifier = "ChapterContentViewController"
    
   
    
    
    
    //property to populate the tableView
    var verses: [Verse] = []
    
    var chapter: Chapter?
    var bookName: String?
    var chapterNumber: Int?

    //add a property to track whether view controller is being presented or dismissed
    var isPresenting: Bool = true
    var interactiveTransition: UIPercentDrivenInteractiveTransition!
    
    
    
    var originalFrame: CGRect?
    
    
    
    //add interactor property same one used by both chapter and media view controller
    let interactor = Interactor()
    
    
    //configure function - passing a specific chapter into the view controller from page view controller
    func configure(with chapter: Chapter, bookName: String)
    {
        self.chapter = chapter
        self.bookName = bookName
        self.chapterNumber = chapter.chapterNumber
        let unsortedVerses = chapter.verses
        let sortedVerses = unsortedVerses.sorted(by: {$0.verseNumber < $1.verseNumber})
        self.verses = sortedVerses
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 3
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        addPanGesture()
    }
    
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let bookName = bookName, let chapter = chapter else { return }
        self.navigationItem.title =  "\(bookName) \(chapter.chapterNumber)"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return verses.count
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        originalFrame = mediaContainerView.frame
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "verseCell", for: indexPath) as? VerseTableTableViewCell
        let verse = verses[indexPath.row]
        cell?.updateCell(verse: verse)
        return cell ?? VerseTableTableViewCell()
    }
    
    //MARK: - TableView Delegate function
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let verseNumber = indexPath.row
        if navigationItem.title == "Genesis 1" {
            if verseNumber == 1 {
            }
        }
    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destinationViewController = segue.destination as? MediaViewController {
//            //when you set the transitioning delegate, you can take manual control of animated transitions 
//            destinationViewController.transitioningDelegate = self
//            //passes interactor object so both VCs are using the same one
//            destinationViewController.interactor = interactor
//        }
//    }
}
       
        
        
//extension ChapterContentViewController: UIViewControllerTransitioningDelegate
//{
//    
//    //method overrides default transition with your custom animation
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        let animator = PresentAnimator()
//        
//        
//    }
//    
//    
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        let animator = PresentAnimator()
//        animator.initalY =
//        animator.transitionType =
//        //return animator
//    }
//    
//    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        return interactor.hasStarted ? interactor : nil 
//    }
//    
//}

extension ChapterContentViewController: UIGestureRecognizerDelegate
{
    
    //create the pan gesture recognizer
    func addPanGesture()
    {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(recognizer:)))
        panGesture.delegate = self
    mediaContainerView.isUserInteractionEnabled = true
    tableView.isUserInteractionEnabled = false 
    mediaContainerView.addGestureRecognizer(panGesture)
    }

    
    func handlePan(recognizer: UIPanGestureRecognizer)//? = nil)
    {
        
        let velocity = recognizer.velocity(in: recognizer.view?.superview).y
        

        
        
        
        //sets how far up the user has to drag in order to trigger the modal presentation
        let percentThreshold: CGFloat = 0.3
        
        
        //convert y position to upward pull progress (percentage)
        //converts pan gesture coordinate to modal view controller's coordinate space
        let translation = recognizer.translation(in: recognizer.view?.superview)
        
        //converts the vertical distance to a percentage based on the overall screen height
        let verticalMovement = translation.y/(view.bounds.height)
        //captures movement in upward direction. downward movement is ignored.
        let upwardMovement = fmaxf(Float(verticalMovement), 0.0)
        //caps percentage to a maximum of 100%
        let upwardMovementPercent = fminf(upwardMovement, 1.0)
        //casts the percentage as a CGFloat which is the number type that the interactor
        let progress = CGFloat(upwardMovementPercent)
        
        switch recognizer.state {
        case .began:
            interactor.hasStarted = true

            
        case .changed:
            if (translation.y < 0) {
                var newFrame = originalFrame
                newFrame?.size.height += translation.y
                self.mediaContainerView.frame = newFrame!
            }
            
            //interactor.shouldFinish = progress > percentThreshold
            //interactor.update(progress)
            
        case.cancelled, .ended:
            interactor.hasStarted = false
            interactor.cancel()

        default:
            break

        }
    }



}


   
