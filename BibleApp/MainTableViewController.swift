//
//  MainTableViewController.swift
//  BibleApp
//
//  Created by Ostap Romaniv on 4/20/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class MainTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainSearchBar: UISearchBar!
    
    var scriptures = [Scripture?]()
    
    var expandSearch: Bool = false {
        didSet{
            if expandSearch {
                searchViewHeightConstraint.constant = 40
            }else {
                searchViewHeightConstraint.constant = 0
            }
            
        }
    }
    var search: [Search] = []

    @IBOutlet var searchViewHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // This method is being called for testing only!!! Delete it, if the app is finished!!!
        loadSampleScriptures()
        
        registerXib()
        configureTableView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    //MARK: IBActions
    
    @IBAction func searchBarButtonPresseed(_ sender: Any) {
        if expandSearch {
            expandSearch = false
        }else {
            expandSearch = true
        }
        updateDataSourceIfNeeded()
        
    }

    // MARK: - Table view data source

    // Register my xib
    func registerXib(){
        mainTableView.register(UINib(nibName: "ScriptureTableViewCell", bundle: nil), forCellReuseIdentifier: "ScriptureCellID")
    }
    
    // Automatically channges the size of the row
    func configureTableView(){
        mainTableView.rowHeight = UITableViewAutomaticDimension
        mainTableView.estimatedRowHeight = 45
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scriptures.count
    }
    

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "ScriptureCellID"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? ScriptureTableViewCell else { return UITableViewCell() }
        
        let scripture = scriptures[indexPath.row]
        
        var attributedScriptureText = NSMutableAttributedString()
        
        // MARK: Editing line and paragraph spacing:
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1
        var range = NSMakeRange(0, attributedScriptureText.string.characters.count)
        
        if (indexPath.row == 0) {
            attributedScriptureText = NSMutableAttributedString(string: "\(indexPath.row + 2)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.clear])
        } else {
            cell.labelOne.isHidden = true
            attributedScriptureText = NSMutableAttributedString(string: "\(indexPath.row + 1)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.blue])
        }
        
        range = NSMakeRange(0, attributedScriptureText.string.characters.count)
        attributedScriptureText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
        
        
        attributedScriptureText.append(NSAttributedString(string: " \((scripture?.text)!)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.black]))
        
        range = NSMakeRange(0, attributedScriptureText.string.characters.count)
        attributedScriptureText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
        
        cell.scriptureText.attributedText = attributedScriptureText
        
        return cell
    }
 

    func loadSampleScriptures() {
        
        let scripture1 = Scripture(text: "In the beginning God created the heaven and the earth.")
        let scripture2 = Scripture(text: "And the earth was without form, and void; and darkness was upon the face of the deep. And the Spirit of God moves upon the face of the waters.")
        let scripture3 = Scripture(text: "And God said, Let there be light: and there was light.")
        
        
        scriptures = [scripture1, scripture2, scripture3]
        
    }
}
extension MainTableViewController {
    
    func searchBarAttributetPlaceholderText(){
        let myAttribute = [ NSForegroundColorAttributeName: UIColor.blue ]
        let myAttrString = NSAttributedString(string: "", attributes: myAttribute)

    }
    
    
    func updateDataSourceIfNeeded() {
        fetchSearch { success in
            if success {
                
                //self.tableView.reloadData()
                //self.tableView.stopPullRefreshEver()
            }
        }
    }
    private func fetchSearch(completion: @escaping (_ sucess: Bool)-> Void){
        Search.getBible{searchResult, error in
            if let fetchedSearch = searchResult{
                //self.search = fetchedSearch
            
                    //print(self.search[0].matchingData!)
                
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
