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

    
    //configure function - passing a specific chapter into the view controller from page view controller
    func configure(with chapter: Chapter, bookName: String)
    {
        self.chapter = chapter
        self.bookName = bookName
        let chapterNumber = chapter.chapterNumber
        let unsortedVerses = chapter.verses
        let sortedVerses = unsortedVerses.sorted(by: {$0.verseNumber < $1.verseNumber})
        self.verses = sortedVerses
        self.navigationItem.title = "Test"
      
    }
    
    
    @IBAction func bookAndChapterButtonTapped(_ sender: AnyObject) {
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 3
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
 
        
    }
        

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    //what happens when the user taps on the cell
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let bookName =
        let chapterNumber =
        let verseNumber = 
        
        SermonController.fetchSermon(bookName: bookName, chapterNumber: chapterNumber, verseNumber: verseNumber) { (sermons) in
                
        }
    }
    
    
}

//
//extension ChapterContentViewController: UIViewControllerTransitionDelegate {
//    
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return PresentMenuAnimator() //your replacement
//    }
//    
//}
