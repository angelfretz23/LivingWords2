//
//  MainTableViewController.swift
//  BibleApp
//
//  Created by Ostap Romaniv on 4/20/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class MainTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: IBoutlets
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainSearchBar: UISearchBar!
    
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet var searchViewHeightConstraint: NSLayoutConstraint!
    
    //MARK: Variables
    var scriptures = [Scripture?]()
    var search: [Search] = []
    
    var expandSearch: Bool = false {
        didSet{
            if expandSearch {
                searchViewHeightConstraint.constant = 40
            }else {
                searchViewHeightConstraint.constant = 0
            }
            
        }
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleScriptures()
        
        registerXib()
        
        configureTableView()
        
        registerForNotifications()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        registerForNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterFotNotifications()
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
    
    func registerForNotifications(){
    NotificationCenter.default.addObserver(self, selector: #selector(userDidPressClearButton(_:)), name: Notification.Name("UserDidPressedClearButton"), object: nil)
    }
    
    func unregisterFotNotifications(){
        NotificationCenter.default.removeObserver(self)
    }

    // Register my xib
    func registerXib(){
        mainTableView.register(UINib(nibName: "ScriptureTableViewCell", bundle: nil), forCellReuseIdentifier: "ScriptureCellID")
    }
    
    // Automatically channges the size of the row
    func configureTableView(){
        mainTableView.rowHeight = UITableViewAutomaticDimension
        mainTableView.estimatedRowHeight = 45
    }
    
    // MARK: - Table view data source
    
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
                self.search = fetchedSearch
            
                    //print(self.search[0].matchingData!)
                
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
extension MainTableViewController: UITextFieldDelegate {
    
    func userDidPressClearButton(_ notification: NSNotification){
        if searchTextField.text == "" {
            placeholderView.isHidden = false
        }
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if searchTextField.text?.characters.count ?? 0 == 0 {
            placeholderView.isHidden = true
        }else if searchTextField.text == "" {
           //placeholderView.isHidden = false
        }
    
        return true
    }
    
}
