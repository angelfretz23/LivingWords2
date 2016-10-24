//
//  ChapterContentViewController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/13/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit

class ChapterContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bookAndChapterButton: UIButton!
    
    static let storyboardIdentifier = "ChapterContentViewController"
    
    //property to populate the tableView
    var verses: [Verse] = []
    
    var chapter: Chapter?
    var bookName: String?
    var chapterNumber: Int?

    
    let transitionDelegate = TransitioningDelegate()
    
    
    
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
    }
    
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let bookName = bookName, let chapter = chapter else { return }
        self.navigationItem.title =  "\(bookName) \(chapter.chapterNumber)"
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
        let verseNumber = indexPath.row
        guard let bookName = bookName else { return }
        SermonController.fetchSermon(bookName: bookName, chapterNumber: chapterNumber, verseNumber: verseNumber) { (sermons) in
            
//            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "MediaViewController")

            // For presentations which will use a custom presentation controller,
            // it is possible for that presentation controller to also be the
            // transitioningDelegate.  This avoids introducing another object
            // or implementing <UIViewControllerTransitioningDelegate> in the
            // source view controller.
            //
            // transitioningDelegate does not hold a strong reference to its
            // destination object.  To prevent presentationController from being
            // released prior to calling -presentViewController:animated:completion:
            // the NS_VALID_UNTIL_END_OF_SCOPE attribute is appended to the declaration.
            
//            let presentationController = PresentationController(presentedViewController: secondViewController!, presenting: self)
//            
//            secondViewController?.transitioningDelegate = presentationController
//            
//            self.present(secondViewController!, animated: true, completion: {
//                let _ = presentationController
        }
        
            transitioningDelegate = TransitioningDelegate()
            var vc = MediaViewController()
            vc.transitioningDelegate = transitioningDelegate
            self.present(vc, animated: true, completion: nil)
            
        }
    
    
    
}





