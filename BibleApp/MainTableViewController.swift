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

    //MARK: IBOutlets
    
    @IBOutlet weak var mainTableView: UITableView!
    
    @IBOutlet weak var placeholderView: UIView!
    
    @IBOutlet var searchViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var searchIconView: UIView!
    @IBOutlet weak var seseparatorView: UIView!
    
    @IBOutlet weak var bookTextField: UITextField!
    @IBOutlet weak var chapterTextField: UITextField!
    @IBOutlet weak var verseTextField: UITextField!
    
    @IBOutlet weak var chapterLayout: NSLayoutConstraint!
    
    @IBOutlet weak var autocompleteView: UIView!
    @IBOutlet weak var autocompliteHeightLayout: NSLayoutConstraint!
    @IBOutlet weak var autocompleteTableView: UITableView!
    
    //MARK: Variables

    var scriptures = [Scripture?]()
    var search: [Search] = []
    
    var autocomplete = [String]()
    var heightAutoComplete = 0
    
    var book: String?
    var chapter: String?
    var verse: String?
    
    let bookNames = ["Ge", "Gen", "Genes", "Masha", "Genesis", "Masha", "Genesis"]
    var testBookNames = [String]()
     var arrayWithoutDuplicates = [String]()
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
        
        styleTheAutompletionTable()
        
        heightAutoComplete = Int(0.45 * view.frame.height)
        autocompliteHeightLayout.constant = 0
        
        // delegates
        mainTableView.delegate = self
        autocompleteTableView.dataSource = self
        autocompleteTableView.delegate = self
        
        bookTextField.delegate = self
        chapterTextField.delegate = self
        verseTextField.delegate = self
        
        self.tabBarController?.tabBar.items![1].image = UIImage(named: "BookTabBarIcon")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(serchViewTapped(tapGestureRecognizer:)))
        searchIconView.addGestureRecognizer(tapGesture)
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
        expandSearch = !expandSearch
    }

    @IBAction func textFieldsEditing(_ sender: UITextField) {
        if sender === bookTextField {
            requestForAutocompletion()
//            testBookNames = bookNames.filter {$0.contains(bookTextField.text!)}
//            autocompleteTableView.reloadData()
        }
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
        autocompleteTableView.register(UINib(nibName: "UITableViewCell", bundle: nil), forCellReuseIdentifier: "autoCompleteCell")
    }
    
    // Automatically changes the size of the row
    func configureTableView(){
        mainTableView.rowHeight = UITableViewAutomaticDimension
        mainTableView.estimatedRowHeight = 45
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.mainTableView.endEditing(true)
    }
    
    func serchViewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        searchIconView.isHidden = true
    }
}

//Private

extension MainTableViewController {
    
    func makeSearch() {
        book = bookTextField.text ?? ""
        chapter = chapterTextField.text ?? ""
        verse = verseTextField.text ?? ""
        
        if !book!.isEmpty && !chapter!.isEmpty && !verse!.isEmpty {
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

        return autocompleteTableView === tableView ? arrayWithoutDuplicates.count : search.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return autocompleteTableView === tableView ? autoComplete(tableView, cellForRowAt: indexPath) : scriptureCell(tableView, cellForRowAt: indexPath)
    }
    
    
}

fileprivate typealias TableDelegate = MainTableViewController
extension TableDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
            if let fetchedSearch = searchResult {
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

    }

    // Method for autocompletion
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        UIView.animate(withDuration: 1) { 
            textField.invalidateIntrinsicContentSize()
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       // textField.placeholder = ""
        if textField === bookTextField {
            autocompleteViewHide(should: false)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField === bookTextField {
            autocompleteViewHide(should: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === bookTextField {
            if textField.text! == "" {
                textField.resignFirstResponder()
            }
        }
        makeSearch()
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
    
    fileprivate func autocompleteViewHide(should hide: Bool) {

        autocompliteHeightLayout.constant = CGFloat(hide ? 0 : self.heightAutoComplete)
        
        UIView.animate(withDuration: 0.6) {
            self.view.layer.layoutIfNeeded()
        }
        
    }
    
    fileprivate func scriptureCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ScriptureTableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScriptureCellID", for: indexPath) as? ScriptureTableViewCell else { return  ScriptureTableViewCell() }
        
        cell.delegate = self
        
        let scripture = search[indexPath.row]
        
        if let typeMedia = scripture.checkedMedia {
            cell.setScriptureImage(with: typeMedia)
        }
        
        configurationScriptureText(cell: cell, scripture: scripture, indexPath: indexPath)
        
        return cell
    }
    
    fileprivate func autoComplete(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "autoCompleteCell")
        cell.textLabel?.text = arrayWithoutDuplicates[indexPath.row]
        cell.contentView.backgroundColor = UIColor.init(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        
        return cell
    }
    
    fileprivate func requestForAutocompletion() {
        self.testBookNames = []
        Search.requestForAutocomplete(key: bookTextField.text!, completion: { (response, error) in
            if let response = response {
                for i in response {
                    self.testBookNames += [i.book_name!]
                    self.arrayWithoutDuplicates = Array(Set(self.testBookNames.filter({ (i: String) in self.testBookNames.filter({ $0 != i }).count > 1})))
                      self.autocompleteTableView.reloadData()
                }
               self.autocompleteTableView.reloadData()
            } else if let error = error {
                print("🔴\(error)🔴")
            }
        })
    }
    
    fileprivate func styleTheAutompletionTable() {
        self.autocompleteTableView.layer.cornerRadius = 20
    }
}
extension MainTableViewController: ScriptureTableViewCellDelegate {
    func userDidDoubleTapScripture(cell: ScriptureTableViewCell) {
        guard let indexPath = mainTableView.indexPath(for: cell),
            let scriptureId = search[indexPath.row].matchingData?.bibleBookVerse?.bibleBookVerseID
            else { return }
        
        Search.setHighlightsScripture(verseId: scriptureId, completion: { success in
            if success {
                SVProgressHUD.showSuccess(withStatus: "DoubleTap")
            }
        })
    }
    
    func userDidSingleTapScripture(cell: ScriptureTableViewCell) {
        
        guard let indexPath = mainTableView.indexPath(for: cell) else {return }
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
