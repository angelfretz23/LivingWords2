//
//  ScriptureTagsViewController.swift
//  BibleApp
//
//  Created by Oleh on 5/11/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit
import SVProgressHUD

class ScriptureSelectionViewController: UIViewController {

    
    struct Constants {
        static let ScriptureSelectionTableViewCell = "ScriptureSelectionTableViewCell"
        static let ScriptureSelectionTableViewCellID = "ScriptureSelectionTableViewCellID"
    }
    
    @IBOutlet weak var scriptureSelectionTableView: UITableView!
    
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var searchIconView: UIView!
    
    @IBOutlet weak var tagScriptureLabel: UILabel!
    
    @IBOutlet weak var searchTextField: CustomTextField!
    
    var backController: UploadSermonesVC?

    var sermonTags: [[String]] = []
   
    var search: [Search] = []
    
    var book: String?
    var chapter: String?
    var verse: String?
    
    @IBAction func saveTagScriptureButtonPressed(_ sender: Any) {
        
        backController?.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        registerXib()
        
        configureTableView()
        
        registerForNotifications()
        
        updateDataSourceIfNeeded()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        registerForNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterFotNotifications()
    }
    
    //MARK: IBActions

    
    func registerForNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(userDidPressClearButton(_:)), name: Notification.Name("UserDidPressedClearButton"), object: nil)
    }
    
    func unregisterFotNotifications(){
        NotificationCenter.default.removeObserver(self)
    }
    
    // Register my xib
    func registerXib(){
        scriptureSelectionTableView.register(UINib(nibName: Constants.ScriptureSelectionTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.ScriptureSelectionTableViewCellID)
    }
    
    // Automatically channges the size of the row
    func configureTableView(){
        scriptureSelectionTableView.rowHeight = UITableViewAutomaticDimension
        scriptureSelectionTableView.estimatedRowHeight = 45
    }
 
    
}

//Private

extension ScriptureSelectionViewController {
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
        default:
            break
        }
        updateSearch()
        
    }
}


fileprivate typealias TableDataSource = ScriptureSelectionViewController
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
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ScriptureSelectionTableViewCellID, for: indexPath) as? ScriptureSelectionTableViewCell else { return UITableViewCell() }
        
        
        let scripture = search[indexPath.row]
        cell.scriptureLabel.attributedText = setAttributedIndexForRows(indexPath: indexPath, scripture: (scripture.matchingData?.bibleBookVerse?.verse)!)
        
        if indexPath.row == 0 {
            cell.firstIndexLabel.isHidden = false
        } else {
            cell.firstIndexLabel.isHidden = true
        }
        
        return cell
    }
    
    func setAttributedIndexForRows(indexPath: IndexPath, scripture: String) -> NSMutableAttributedString{
        
        let indexAttributes = [NSForegroundColorAttributeName: UIColor.blue]
        let scriptureAttributes =  [NSForegroundColorAttributeName: UIColor.black]
        
        let attributedIndexText = NSAttributedString(string: "\(indexPath.row + 1)" + " ", attributes: indexAttributes)
        let attributedSctipture = NSAttributedString(string:scripture, attributes: scriptureAttributes)
        
        let result = NSMutableAttributedString()
        
        if indexPath.row == 0 {
            let attributedSctiptureFirstIndex = NSAttributedString(string:"   " + scripture, attributes: scriptureAttributes)
            result.append(attributedSctiptureFirstIndex)
            return result
        }
            result.append(attributedIndexText)
            result.append(attributedSctipture)
            return result
        
    }
}

extension ScriptureSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard  let cell = tableView.cellForRow(at: indexPath) as? ScriptureSelectionTableViewCell else { return }
        cell.cellIsSelected = true
        
        var countOfSelectedCells = [0]
        
        if cell.isSelected {
            countOfSelectedCells += [1]
        }
        
        let scripture = search[indexPath.row]
        let index = indexPath.row + 1
        
        scripture.bookOfBible = book
        scripture.chapterNumberOfBook = chapter
        scripture.verse = verse
        
        
        self.sermonTags = [[scripture.bookOfBible! + " " + scripture.chapterNumberOfBook! + ": \(index + 1)"]]
        
        for i in sermonTags {
            for a in i {
                self.tagScriptureLabel.text = a
                self.backController?.scriptureTags.text = a
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
      
    }
}

extension ScriptureSelectionViewController {
    
    func updateSearch(){
        SVProgressHUD.show()
        SVProgressHUD.setBackgroundColor(UIColor.init(red: 195/255, green: 194/255, blue: 201/255, alpha: 1))
        getSearchResults { success in
            if success {
                SVProgressHUD.dismiss()
                self.scriptureSelectionTableView.reloadData()
            }
        }
    }
    
    func getSearchResults(completion: @escaping (_ sucess: Bool)-> Void){
        Search.searchBible(book: book ?? "", chapter: chapter ?? "", verse: verse ?? "", completion:  {search, error  in
            if let seachResult = search {
                self.search = seachResult
                completion(true)
            }else {
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
                self.scriptureSelectionTableView.reloadData()
             
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
}
extension ScriptureSelectionViewController: UITextFieldDelegate {
    
    func userDidPressClearButton(_ notification: NSNotification){
        if searchTextField.text == "" {
            placeholderView.isHidden = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getParametersWordsFromSearchFieldForRequest(searchTextField.text!)
        textField.resignFirstResponder()
        return true
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if searchTextField.text?.characters.count ?? 0 == 0 {
            placeholderView.isHidden = true
        }else if searchTextField.text == "" {
            //placeholderView.isHidden = false
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchIconView.isHidden = true
        //seseparatorView.isHidden = true
    }
}
