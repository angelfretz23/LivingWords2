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
    func configure(with chapter: Chapter)
    {
        self.chapter = chapter
        let chapterNumber = chapter.chapterNumber
        //let bookName = bookName
        let unsortedVerses = chapter.verses
        let sortedVerses = unsortedVerses.sorted(by: {$0.verseNumber < $1.verseNumber})
        self.verses = sortedVerses
        let titleOfButton = "\(bookName) \(chapterNumber)"
        bookAndChapterButton.setTitle(titleOfButton, for: .normal)
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
        
        bookAndChapterButton.titleLabel?.adjustsFontSizeToFitWidth = true
        bookAndChapterButton.titleLabel?.numberOfLines = 1
        
    }
        

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
