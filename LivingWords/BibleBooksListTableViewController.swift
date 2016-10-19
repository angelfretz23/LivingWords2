//
//  BibleBooksListTableViewController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/12/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit


class BibleBooksListTableViewController: UITableViewController {
    
    

    //set up VC and get it to display collectioned TV cells , each table row has an entry in the outer array and each row needs an array of things for the collection view cells
  
    //make it optional, will be used to expand and retract cells
    var selectedIndexPath: NSIndexPath?
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookController.arrayOfBooksInBible.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "chapterCell", for: indexPath) as? ChapterTableViewCell
            return cell!
    }
    
    
    
    //MARK: - TableViewDelegate functions
    
    //this is called just before the cell is about to be displayed
    //tells tableView that VC will handle collection view, now we need to conform in an extension.
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? ChapterTableViewCell else { return }
        
     tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let previousIndexPath = selectedIndexPath
//        if indexPath == selectedIndexPath {
//            selectedIndexPath = nil
//        } else {
//            selectedIndexPath = indexPath
//        }
        
        
        
        
    }
    
    
    
    
    func selectBibleBookAndChapter(book: String, chapter: String) {
        
        
        
        
    }
    
    
    
//     MARK: - Navigation
//     In a storyboard-based application, you will often want to do a little preparation before navigation

    
    
    
    

}

//in both methods, use collectionview.tag to determine which of the outer arrays to access,then return number of items in that collection view or a configured cell
extension BibleBooksListTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    
    //STEP 2 CV: tell the collection view how many cells to make in each row
    //in this case, arrayOfBookChapters, contains the number of books in the bible and collectionView.tag is the row, so in row 1, it should make X number of cells based on the number of books in slot 1 of the array
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return ChapterController.arrayOfBookChapters[collectionView.tag]
    }
    
    //STEP 3: make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chapterCollectionCell", for: indexPath) as! ChapterCollectionViewCell
        //use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.chapterLabel.text = ChapterController.chapterLabels[indexPath.item]
        return cell
        
    }
    
    
    
    //header function
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //kind parameter is supplied by the layout object and indicates which sort of supplementary view is being asked for
        switch kind {
        //supplementary view kind belonging to the flow layout. By checking that box in the storyboard to add a section header, you told the flow layout it needs to start asking for these views.
        case UICollectionElementKindSectionHeader:
            //header view is dequeued using the identifier added in the storyboard
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "bookHeader", for: indexPath) as! BookHeaderCollectionReusableView
            headerView.bookHeaderLabel.text = BookController.arrayOfBooksInBible[collectionView.tag]
            return headerView
        default:
            assert(false, "Unexpected element")
        }
    }
    
    
    
    //Delegate methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        
        
        
           
        }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPageViewController" {
            if let collectionCell: ChapterCollectionViewCell = sender as? ChapterCollectionViewCell,
                //NOTE: This was the hard part trying to get access to collection view since it was declared in the table view cell. http://stackoverflow.com/questions/34486465/how-can-i-segue-from-uicollectionviews-cells-embedded-inside-uitableviewcell-s/35530349
                let collectionView: UICollectionView = collectionCell.superview as? UICollectionView,
                let destinationVC = segue.destination as? ChapterPageViewController {
                // Pass some data to YourViewController
                // collectionView.tag will give your selected tableView index
                let bookName = BookController.arrayOfBooksInBible[collectionView.tag]
                guard let chapterNumberStringValue = collectionCell.chapterLabel.text,
                      let chapterNumber = Int(chapterNumberStringValue)else { return }
                destinationVC.bookName = bookName
                destinationVC.chapterNumber = chapterNumber

            }
                
        }
    }
}


















