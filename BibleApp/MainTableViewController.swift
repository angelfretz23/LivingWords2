//
//  MainTableViewController.swift
//  BibleApp
//
//  Created by Ostap Romaniv on 4/20/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var scriptures = [Scripture?]()

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    // Register my xib
    func registerXib(){
        tableView.register(UINib(nibName: "ScriptureTableViewCell", bundle: nil), forCellReuseIdentifier: "ScriptureCellID")
    }
    
    // Automatically channges the size of the row
    func configureTableView(){
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 45
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scriptures.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // This method was created for testing only!!!
    func loadSampleScriptures() {
        
        let scripture1 = Scripture(text: "In the beginning God created the heaven and the earth.")
        let scripture2 = Scripture(text: "And the earth was without form, and void; and darkness was upon the face of the deep. And the Spirit of God moves upon the face of the waters.")
        let scripture3 = Scripture(text: "And God said, Let there be light: and there was light.")
        
        
        scriptures = [scripture1, scripture2, scripture3]
        
    }

}
