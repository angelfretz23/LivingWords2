//
//  UploadMusicTVC.swift
//  BibleApp
//
//  Created by Mac on 5/10/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class UploadMusicTVC: UITableViewController {



    // MARK: - Properties
    var names = ["Psalm23:4", "Genesis1:1", "Matthew14:29"]
    fileprivate var selectedIndex: IndexPath?
    fileprivate var isExpanded = false
    fileprivate var allowExpanded = false
    var cellTop: TopCellUploadMusicCell?
    var cellExpandable: MusicUploadTVC?
    var cellBottom: BottomUploadMusicCell?
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName: "TopCellUploadMusicCell", bundle: nil), forCellReuseIdentifier: "TopCellUploadMusicCellID")
        tableView.register(UINib.init(nibName: "MusicUploadTVC", bundle: nil), forCellReuseIdentifier: "ExpandableCell")
        tableView.register(UINib.init(nibName: "BottomUploadMusicCell", bundle: nil), forCellReuseIdentifier: "BottomUploadMusicCellID")
    }

    fileprivate func makeExpandedCell() {
        isExpanded = !isExpanded
        tableView.reloadRows(at: [selectedIndex!], with: .automatic)
    }
    
    // MARK: IBActions
    
    @IBAction func uploadMusic(_ sender: UIBarButtonItem) {
        let artistName = cellTop?.artistName.text ?? ""
        let writerName = cellTop?.writerName.text ?? ""
        let tagScriptures = cellExpandable?.textScripture.text ?? ""
        
    }
    
    @IBAction func cancellAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - Extensions
extension TableDataSource {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 || section == 2 {
            return 1
        }

        return names.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
          return topUploadMusicCell(tableView, cellForRowAt: indexPath)
        }
       
        if indexPath.section == 2 {
            return bottomUploadMusicCell(tableView, cellForRowAt: indexPath)
        }
        
         return expandedCell(tableView, cellForRowAt: indexPath)
    }
    
}

extension TableDelegate {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        makeExpandedCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 || indexPath.section == 2 {
            return 311
        } else {
            
            if isExpanded && selectedIndex == indexPath {
                return 150
            } else {
                return 48
            }
        }
    }
}

extension UploadMusicCells {
    
    fileprivate func expandedCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableCell", for: indexPath) as! MusicUploadTVC
            cellExpandable = cell
        if names[indexPath.row] != "" {
            cell.titleScripture.text = names[indexPath.row]
            cell.selectionStyle = .none
        }

        return cell
    }

    fileprivate func topUploadMusicCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopCellUploadMusicCellID", for: indexPath) as!
        TopCellUploadMusicCell
        cellTop = cell
            cell.selectionStyle = .none
        return cell
    }
    
    fileprivate func bottomUploadMusicCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BottomUploadMusicCellID", for: indexPath) as! BottomUploadMusicCell
        cellBottom = cell
        cell.selectionStyle = .none
        return cell
    }
}

private typealias TableDataSource = UploadMusicTVC
private typealias TableDelegate = UploadMusicTVC
private typealias UploadMusicCells = UploadMusicTVC
