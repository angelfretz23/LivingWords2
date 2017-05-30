//
//  MainTableViewController.swift
//  BibleApp
//
//  Created by Ostap Romaniv on 4/20/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit
import SVProgressHUD

class MainTableViewController: UIViewController {
    

    @IBOutlet weak var switchMedia: UISwitch!

    //MARK: IBoutlets
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainSearchBar: UISearchBar!
    
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet var searchViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var searchIconView: UIView!
    @IBOutlet weak var seseparatorView: UIView!
    //MARK: Variables

    var scriptures = [Scripture?]()
    var search: [Search] = []
    
    var autocomplete = [String]()
    
    var book: String?
    var chapter: String?
    var verse: String?
    
    var expandSearch: Bool = false {
        didSet {
            if expandSearch {
                seseparatorView.isHidden = !expandSearch
                UIView.animate(withDuration: 0.5, delay: 0.1, options: .transitionFlipFromTop, animations: {
                self.searchViewHeightConstraint.constant = 40
                    self.view.layoutIfNeeded()
                }, completion: nil)
            } else {
                seseparatorView.isHidden = !expandSearch
                UIView.animate(withDuration: 0.5, delay: 0.1, options: .transitionFlipFromTop, animations: {
                    self.searchViewHeightConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerXib()
        
        configureTableView()
        
        registerForNotifications()
        
        updateDataSourceIfNeeded()
        
        // delegates
        searchTextField.delegate = self
        mainTableView.delegate = self
        
        self.tabBarController?.tabBar.items![1].image = UIImage(named: "BookTabBarIcon")
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
        expandSearch = expandSearch ? false : true
        
        //updateDataSourceIfNeeded()
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
    
    // Automatically changes the size of the row
    func configureTableView(){
        mainTableView.rowHeight = UITableViewAutomaticDimension
        mainTableView.estimatedRowHeight = 45
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.mainTableView.endEditing(true)
    }
}

//Private

extension MainTableViewController {
    func getParametersWordsFromSearchFieldForRequest(_ searchString: String) {
        if searchString == "" {return}
        let searchParameters = searchString.components(separatedBy: " ")
        switch searchParameters.count {
        case 0:
            book = ""
            chapter = ""
            verse = ""
        case 1:
            book = searchParameters[0]
            chapter = ""
            verse = ""
        case 2:
            book = searchParameters[0]
            chapter = searchParameters[1]
            verse = ""
        case 3:
            book = searchParameters[0]
            chapter = searchParameters[1]
            verse = searchParameters[2]
            
            if ((book?.isEmpty)! && (chapter?.isEmpty)! && (verse?.isEmpty)!) {
                print("🔴 User didn't input any data to search for 🔴")
                
            } else {
            
                if let index = verse {
                    let index = Int(index)! - 1
                    let indePath: IndexPath = [0, index]
                    
                    UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn, animations: {
                        self.mainTableView.scrollToRow(at: indePath, at: .top, animated: true)
                    }, completion: nil)
                    
                    return
                } else {
                    self.displayAlert(userMessage: "Fill the search-field as in example: Book Chapter Verse!")
                }
            }
            
        default:
            break
        }
        updateSearch()
        
    }
}

fileprivate typealias TableDataSource = MainTableViewController
extension TableDataSource : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return search.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScriptureCellID", for: indexPath) as? ScriptureTableViewCell else { return UITableViewCell() }
        
        let scripture = search[indexPath.row]
        
        if let typeMedia = scripture.checkedMedia {
            cell.setScriptureImage(with: typeMedia)
        }
        
        configurationScriptureText(cell: cell, scripture: scripture, indexPath: indexPath)
        
        return cell
    }
    
    
}

fileprivate typealias TableDelegate = MainTableViewController
extension TableDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        let bibleBookVerseID = search[indexPath.row].matchingData?.bibleBookVerse?.bibleBookVerseID
        SVProgressHUD.show()
        
        if let verseID = bibleBookVerseID {

            Verse.verseMedia(verse_id: verseID, completion: { (verse, error) in
                if error != nil {
                    print("🍎some error ocurred with verse media🍎 \(error!)")
                    return
                }
            
                self.presentMediaController(verse: verse)
            })
        }

    }
    
}

extension MainTableViewController {
    
    func updateSearch(){
        SVProgressHUD.show()
        SVProgressHUD.setBackgroundColor(UIColor.init(red: 195/255, green: 194/255, blue: 201/255, alpha: 1))
        getSearchResults { success in
            if success {
                SVProgressHUD.dismiss()
            self.mainTableView.reloadData()
            }
        }
    }

    func getSearchResults(completion: @escaping (_ sucess: Bool)-> Void){
        Search.searchBible(book: book ?? "", chapter: chapter ?? "", verse: verse ?? "", completion:  {search, error  in
            if let seachResult = search {
                self.search = seachResult
                completion(true)
            } else {
                completion(false)
            }
        })
    }
        
    func updateDataSourceIfNeeded() {
        SVProgressHUD.show()
        SVProgressHUD.setBackgroundColor(UIColor.init(red: 195/255, green: 194/255, blue: 201/255, alpha: 1))
        fetchSearch { success in
            if success {
                SVProgressHUD.dismiss()
                self.mainTableView.reloadData()
                //self.mainTableView.stopPullRefreshEver()
            }
        }
    }
    private func fetchSearch(completion: @escaping (_ sucess: Bool)-> Void){
        Search.getBible{searchResult, error in
            if let fetchedSearch = searchResult{
                self.search = fetchedSearch
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    fileprivate func displayAlert(userMessage: String) {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }

}

extension MainTableViewController: UITextFieldDelegate {
    
    func userDidPressClearButton(_ notification: NSNotification){
        if searchTextField.text == "" {
            placeholderView.isHidden = false
        }
    }

    // Method for autocompletion
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if searchTextField.text?.characters.count ?? 0 == 0 {
            placeholderView.isHidden = true
        } else if searchTextField.text == "" {
           //placeholderView.isHidden = false
        }
    
        let substring = (self.searchTextField.text! as NSString).replacingCharacters(in: range, with: string)
        
        searchAutocompleteEntriesWithSubstring(substring)

        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchIconView.isHidden = true
        seseparatorView.isHidden = true
    }
    
    func searchAutocompleteEntriesWithSubstring(_ substring: String)
    {
        autocomplete.removeAll(keepingCapacity: false)
        
        for curString in ["\(search)"]
        {
            let myString:NSString! = curString as NSString
            
            let substringRange :NSRange! = myString.range(of: substring)
            
            if (substringRange.location == 0)
            {
                autocomplete.append(curString)
            }
        }
        
        mainTableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        getParametersWordsFromSearchFieldForRequest(searchTextField.text ?? "")
        textField.resignFirstResponder()
        
        return true
    }
}

extension MainTableViewController {
    
    fileprivate func presentMediaController(verse: Verse?) {
        
        let storyboard = UIStoryboard(name: "Media", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainMediaViewControllerID") as! MainMediaViewController
        controller.controllerScripture = self
        controller.verses = verse
        
        SVProgressHUD.dismiss()
        self.present(controller, animated: true, completion: nil)
        print("🍏verse`s Id is here🍏")
    }
    
    fileprivate func configurationScriptureText( cell: ScriptureTableViewCell, scripture: Search, indexPath: IndexPath) {
        
        var attributedScriptureText = NSMutableAttributedString()
        
        if (indexPath.row == 0) {
            cell.labelOne?.isHidden = false
            attributedScriptureText = NSMutableAttributedString(string: "\(indexPath.row + 2)" + " ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.clear])
        } else {
            cell.labelOne?.isHidden = true
            attributedScriptureText = NSMutableAttributedString(string: "\(indexPath.row + 1)" + ". ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.blue])
        }
        
        let string = " " + (scripture.matchingData?.bibleBookVerse?.verse)!
        attributedScriptureText.append(NSAttributedString(string:string , attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.black]))
        
        cell.scriptureText?.attributedText = attributedScriptureText
    }
}
