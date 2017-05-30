//
//  BookUploadViewController.swift
//  BibleApp
//
//  Created by Oleh on 5/11/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class BookUploadViewController: UIViewController {
    
    //MARK: Constants
    
    fileprivate struct Constants {
        static let AuthorNameTableViewCell = "AuthorNameTableViewCell"
        static let AuthorNameTableViewcellReuseID = "AuthorNameTableViewCellID"
        
        static let UploadBookTableViewCell = "UploadBookTableViewCell"
        static let UploadBokkTableViewCellReuseID = "UploadBookTableViewCellID"
        
        static let TagScriptureTableViewCell = "TagScriptureTableViewCell"
        static let TagScriptureTableViewCellReuseID = "TagScriptureTableViewCellID"
        
        static let BookDescriptionTableViewCell = "BookDescriptionTableViewCell"
        static let BookDescriptionTableViewCellReuseID = "BookDescriptionTableViewCellID"
        
        static let TagsTableViewCell = "TagsTableViewCell"
        static let TagsTableViewCellReuseID = "TagsTableViewCellID"
    }

    //MARK:- IBOutlets
    
    @IBOutlet weak var bookUploadTableView: UITableView!
    
    
    //MARK:- Properties
    
    var tagScriptureString: String = "Tag Scriptures"
    @IBOutlet weak var tableView: UITableView!
    
    // cells to fetch information
    fileprivate var authorNameCell: AuthorNameTableViewCell?
    fileprivate var bookUploadCell: UploadBookTableViewCell?
    fileprivate var tagScriptureCell: TagScriptureTableViewCell?
    fileprivate var bookDescriptionCell: BookDescriptionTableViewCell?
    fileprivate var tagCell: TagsTableViewCell?
    
    //MARK:- BookUpload`s life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        registerXibs()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if isYouTubeLoaded {
            if let cell = bookUploadCell {
                cell.bookImage.image = #imageLiteral(resourceName: "On My Soul")
            }
        }
        
        if let tagCell = tagScriptureCell {
            tagCell.tagScriptureLabel.text = tagScriptureString
        }
        
    }
    
    // MARK:- Action and Other helpfull methods
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareAction(_ sender: UIBarButtonItem) {
        
        let author_name = authorNameCell?.authorName.text ?? "test user"
        let media_link = videoUrl ?? "amazon.com"
        let tagscripture = scriptureIDArray ?? [1]
        let book_name = bookDescriptionCell?.bookName.text ?? "Hanry Ford"
        let publish_date = bookDescriptionCell?.publishDate.text ?? "24/08/1991"
        let summary = bookDescriptionCell?.summary.text ?? "Book"
        let tags = self.makeArrayOfHashtags(incomingString: tagCell?.tags.text ?? "") ?? ["#test"]
        
        Post.uploadBook(author_name: author_name, media_link: media_link, tag_scripture: tagscripture,
                        book_name: book_name, publish_date: publish_date, summary: summary, tags: tags)
        { (post, error) in
            if error != nil {
                print("🍎Upload Book🍎")
                return
            }
            
            print("🍏 Upload book 🍏")
        }
        
    }
    
    func configureTableView(){
        bookUploadTableView.rowHeight = UITableViewAutomaticDimension
        bookUploadTableView.estimatedRowHeight = 300
    }
    
    func registerXibs(){
        bookUploadTableView.register(UINib(nibName: Constants.AuthorNameTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.AuthorNameTableViewcellReuseID)
        bookUploadTableView.register(UINib(nibName: Constants.UploadBookTableViewCell, bundle: nil), forCellReuseIdentifier:  Constants.UploadBokkTableViewCellReuseID)
        bookUploadTableView.register(UINib(nibName: Constants.TagScriptureTableViewCell, bundle: nil), forCellReuseIdentifier:  Constants.TagScriptureTableViewCellReuseID)
        bookUploadTableView.register(UINib(nibName: Constants.BookDescriptionTableViewCell, bundle: nil), forCellReuseIdentifier:  Constants.BookDescriptionTableViewCellReuseID)
        bookUploadTableView.register(UINib(nibName: Constants.TagsTableViewCell, bundle: nil), forCellReuseIdentifier:  Constants.TagsTableViewCellReuseID)
    }
}

extension BookUploadViewController:  UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath {
        case [0,0]:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.AuthorNameTableViewcellReuseID, for: indexPath) as? AuthorNameTableViewCell else { return UITableViewCell() }
            authorNameCell = cell
            return cell
        case [0,1]:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UploadBokkTableViewCellReuseID, for: indexPath) as? UploadBookTableViewCell else { return UITableViewCell() }
            bookUploadCell = cell
            return cell
        case [1,0]:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TagScriptureTableViewCellReuseID, for: indexPath) as? TagScriptureTableViewCell else { return UITableViewCell() }
            cell.tagScriptureLabel.text = tagScriptureString == "" ? "Tag Scriptures" : tagScriptureString
            tagScriptureCell = cell
            return cell
        case [2,0]:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.BookDescriptionTableViewCellReuseID, for: indexPath) as? BookDescriptionTableViewCell else { return UITableViewCell() }
            bookDescriptionCell = cell
            return cell
        case [3,0]:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TagsTableViewCellReuseID, for: indexPath) as? TagsTableViewCell else { return UITableViewCell() }
            tagCell = cell
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.AuthorNameTableViewcellReuseID, for: indexPath) as? AuthorNameTableViewCell else { return UITableViewCell() }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Scriptures"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0, 1:
            return 30
        case 2:
            return 30
        case 3:
            return 5
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        
        header.textLabel?.textAlignment = .left
        header.textLabel?.font = UIFont(name: "Futura", size: 12.0)!
        header.textLabel?.textColor = UIColor.lightGray
        if section == 1 {
            header.textLabel?.text = " Scriptures"
        } else {
            
        }
    }
    
}
    
    extension BookUploadViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.section == 1 && indexPath.row == 0 {
                uploadTagScriptures()
            }
            
            if indexPath.section == 0 && indexPath.row == 1 {
                loadLink(with: "https://www.amazon.com", contentProvider: .Author_Book)
            }
        }
        
        func uploadTagScriptures() {
            let storyboard = UIStoryboard(name: "BookUpload", bundle: nil)
            let scriptureSelectionViewController  = storyboard.instantiateViewController(withIdentifier: "ScriptureSelectionViewControllerID") as! ScriptureSelectionViewController
            scriptureSelectionViewController.backController = self
            scriptureSelectionViewController.contentProvider_type = .Author_Book
            self.present(scriptureSelectionViewController, animated: true)
            
            //performSegue(withIdentifier: "GetTagScripturesSegueID", sender: self)
        }
}

