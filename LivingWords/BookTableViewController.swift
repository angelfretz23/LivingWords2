//
//  BookTableViewController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/19/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController {


    //array to populate tableview cells
    var books: [Book] = []
    
    //load all of the books
    override func viewDidLoad() {
        super.viewDidLoad()
        BookController.sharedController.serializeJSON { (books) in
            self.books = books
        }
    }

    
    //properties for cell expansion and collapse
    var cellTapped: Bool = true
    var currentRow = 0
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookTableViewCell
        let book = books[indexPath.row]
        cell?.updateBookLabel(book: book)
        return cell ?? BookTableViewCell()
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let bookTableViewCell = cell as? BookTableViewCell else { return }
        
        bookTableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    //method to set the collection view's data source and delegate as this table view controller. conform to the required protocol methods in the extension below 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedRowIndex = indexPath
        currentRow = selectedRowIndex.row
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == currentRow {
            if cellTapped == false {
                cellTapped = true
                return 220
            } else {
                cellTapped = false
                return 44
            }
        }
        return 44
    }
    
    

}





extension BookTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    

    //tell the collection view how many cells to make in each row
    //in this case, arrayOfBookChapters, contains the number of books in the bible and collectionView.tag is the row, so in row 1, it should make X number of cells based on the number of books in slot 1 of the array
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books[collectionView.tag].chapters.count

    }
    
    //make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chapterCollectionCell", for: indexPath) as? ChapterCollectionViewCell
        //use the outlet in our custom class to get a reference to the UILabel in the cell
        let chapters = books[collectionView.tag].chapters.sorted{$0.chapterNumber < $1.chapterNumber}
        let chapter = chapters[indexPath.item]
        cell?.updateChapterLabel(chapter: chapter)
        cell?.layer.cornerRadius = 8
        return cell ?? ChapterCollectionViewCell()
    }
    
    //Delegate methods
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.gray
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
          let cell = collectionView.cellForItem(at: indexPath)
          cell?.backgroundColor = UIColor.white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPageViewController" {
            if let collectionCell: ChapterCollectionViewCell = sender as? ChapterCollectionViewCell,
                //NOTE: This was the hard part trying to get access to collection view since it was declared in the table view cell. http://stackoverflow.com/questions/34486465/how-can-i-segue-from-uicollectionviews-cells-embedded-inside-uitableviewcell-s/35530349
                let collectionView: UICollectionView = collectionCell.superview as? UICollectionView,
                let destinationVC = segue.destination as? ChapterPageViewController {
                // collectionView.tag will give your selected tableView index
                
                //find index that was tapped in tableView
                guard let indexPath = collectionView.indexPath(for: collectionCell) else { return }
            
                let chapter = books[collectionView.tag].chapters[indexPath.item]
                
                destinationVC.chapterNumber = chapter.chapterNumber
                
                
                
//                destinationVC.bookName = bookName
//                destinationVC.chapterNumber = chapterNumber
                
            }
            
        }
    }
}
