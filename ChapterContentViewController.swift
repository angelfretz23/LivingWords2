//
//  ChapterContentViewController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/13/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
//STEP 2- declare the transitioning delegate and animatedtransitioning protocols in the class definition 




enum Provider: String{ // enum to use as keys
    case youtube = "YouTube"
    case vimeo = "Vimeo"
    case sermon = "Sermon"
}

protocol MediaSource{
    // Protocol to for Youtube, Vimeo, and Sermon Objects to comform to
    var sourceType: Provider { get set }
}



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
    
    
    
    
    var verseMoviesArray: [String] = []
    var verseSermonsArray: [String] = []
    var verseMusicArray: [Music] = []
    var verseBooksArray: [String] = []
    
    
//    // Making an array to hold the objects using the protocol as the type
    let arrayOfObjects: [MediaSource] = []
//
//    //Now when you pull from the array, you check what kind of object is it by using the variable in the protocol and then cast it back to that type
//    
//    arrayOfObjects.forEach { (object) in
//    switch object.sourceType{
//    default: ()
//    }
//    }
    
    
    
    
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
        guard let bookName = bookName, let chapter = chapter?.chapterNumber else { return }
        self.navigationItem.title =  "\(bookName) \(chapter)"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return verses.count
    }
    
    
    
 
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "verseCell", for: indexPath) as? VerseTableTableViewCell
        let verse = verses[indexPath.row]
        cell?.updateCell(verse: verse)
        return cell ?? VerseTableTableViewCell()
    }
    
    
    //MARK: - TableView Delegate function
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let verseNumber = indexPath.row + 1
        guard let bookName = bookName,
              let chapter = chapter?.chapterNumber else { return }
        MusicController.sharedController.fetchVideoIdFromFireBase(bookName: bookName, chapter: String(chapter), verseNumber: String(verseNumber))
        //pull from background thread to main thread
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    

    
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
    tableView.isUserInteractionEnabled = true
    mediaContainerView.addGestureRecognizer(panGesture)
    }

    
    func handlePan(recognizer: UIPanGestureRecognizer)//? = nil)
    {
        
        let translation = recognizer.translation(in: self.view)
        
        if recognizer.view!.frame.size.height - translation.y > 100{ // Minimum size for view is 100
        //NOTE: I did += translation and Angel changed this to -= translation
            recognizer.view!.frame.size.height -= translation.y
            //changed the center, otherwise the center remains the same as before while the frame is increasing
            recognizer.view!.center = CGPoint(x: recognizer.view!.center.x, y: recognizer.view!.center.y + translation.y)
            recognizer.setTranslation(CGPoint(), in: self.view)
        }

    }

}




//[pgr setTranslation:CGPointZero inView:pgr.view];



