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
    fileprivate var selectedIndex: IndexPath?
    fileprivate var isExpanded = false
    var cellTop: TopCellUploadMusicCell?
    var cellExpandable: MusicUploadTVC?
    var cellBottom: BottomUploadMusicCell?
    var scriptureDetailDescript = [UITableViewCell]()
    var post: Post?
    var expandableRowCount: Int?
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
      
        tableView.reloadData()
        tableView.register(UINib.init(nibName: "TopCellUploadMusicCell", bundle: nil), forCellReuseIdentifier: "TopCellUploadMusicCellID")
        tableView.register(UINib.init(nibName: "MusicUploadTVC", bundle: nil), forCellReuseIdentifier: "ExpandableCell")
        tableView.register(UINib.init(nibName: "BottomUploadMusicCell", bundle: nil), forCellReuseIdentifier: "BottomUploadMusicCellID")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        tableView.reloadData()
        if isYouTubeLoaded {
            fetchYouTubeVideoInfo(with: (self.cellTop?.mediaURL)!, imageYouTube: (self.cellTop?.imageOfVideo)!, youTubeId: youTubeId!)
        }
    }
    
    fileprivate func makeExpandedCell() {
        isExpanded = !isExpanded
        tableView.reloadRows(at: [selectedIndex!], with: .automatic)
        tableView.reloadData()
    }
    
    // MARK: IBActions
    @IBAction func uploadMusic(_ sender: UIBarButtonItem) {
        let artistName = cellTop?.artistName.text ?? ""
        let writerName = cellTop?.writerName.text ?? ""
        let songStory = cellBottom?.songStory.text ?? ""
        let descript = cellBottom?.descript.text ?? ""
        let tags = self.makeArrayOfHashtags(incomingString: cellBottom?.tags.text ?? "") ?? [""]
        

        // This Array is created to demonstate
        // Сюди ми маємо передати текст - опис до кожного вірша:
        var arrayToDelete = [String]()
    
        
        for _ in scriptureIDArray! {
            arrayToDelete += ["test"]
        }
        
        let specialFormat = self.combineArrays(first: scriptureIDArray!, second: arrayToDelete) ?? [""]
   
        print("\(specialFormat)")
        
        Post.uploadMusic(artist_name: artistName, writer_name: writerName, music_link: videoUrl ?? "", song_story: songStory, descript: descript, tags: tags, tag_scripture: specialFormat, user_id: 28) { (response, error) in
            
            if let post = response {
                self.post = post
                print("🍏 A post was shared successfully, now you see the response from server! 🍏")
                self.dismiss(animated: true, completion: nil)
            } else if error != nil {
                print("🔴 An \(error) occured while sharing the post! 🔴")
                   self.dismiss(animated: true, completion: nil)
            }
        }
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

        if let count = expandableRowCount {
            return count
        } else { return 0 }
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
    
        if indexPath.section == 0 {
            let cell = tableView.cellForRow(at: indexPath) as! TopCellUploadMusicCell
            let gesture = UITapGestureRecognizer(target: self, action:  #selector(tagTapped(tapGestureRecognizer:)))
            let gesture2 = UITapGestureRecognizer(target: self, action:  #selector(youTubeImageTapped(tapGestureRecognizer:)))
            
            cell.selectionView.addGestureRecognizer(gesture)
            cell.YTVSelectionView.addGestureRecognizer(gesture2)
            
            cell.selectionView.isUserInteractionEnabled = true
            cell.YTVSelectionView.isUserInteractionEnabled = true
            
            cellTop = cell
        } else if indexPath.section == 1 {
            makeExpandedCell()
        }
        
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
        
        var scriptureArray = self.fetch(incomingString: (cellTop?.tagScriptures.text!)!)
        if scriptureArray?[indexPath.row] != "" {
            cell.titleScripture.text = scriptureArray?[indexPath.row]
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
    
    fileprivate func makeArrayOfHashtags(incomingString: String) -> [String]? {
        var tagArray1 = [String]()
        var tagArray2 = ""
        var tagArray3 = [String]()
        var tagArray4 = [String]()
        
        tagArray1 = incomingString.components(separatedBy: " ")
        
        for i in tagArray1 {
            tagArray2 += i
        }
        
        tagArray3 = tagArray2.components(separatedBy: "#")
        tagArray3.remove(at: 0)
        
        for i in tagArray3 {
            tagArray4.append("#" + i)
        }
        
        return tagArray4
    }
    
    fileprivate func fetch(incomingString: String) -> [String]? {
        var array = [String]()
        var string = ""
        var array2 = [String]()
        var resultingArray = [String]()
        
        array = incomingString.components(separatedBy: ",")
        
        for i in array {
            string += i
        }
        
        array2 = string.components(separatedBy: " ")
        let book = array2.first
        array2.remove(at: 0)
        
        for i in array2 {
            resultingArray += [book! + " " + i]
        }
        
        return resultingArray
    }
    
    fileprivate func combineArrays(first: [Int], second: [String]) -> [String]? {
        var result = [String]()
        var helper = [String]()
        
        for i in first {
            helper += [String(i)]
        }
        
        for x in second {
            for i in helper {
                result += [i + ":" + x]
            }
        }
        
        
        result.removeSubrange(result.count/first.count..<result.count)
    
        
        return result
    }
}

extension Gestures {
    func tagTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        uploadTagScriptures(content_provider: .Artist)
    }
    
    func youTubeImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        loadLink(with: "https://youtube.com", contentProvider: .Artist)
    }
}

private typealias TableDataSource = UploadMusicTVC
private typealias TableDelegate = UploadMusicTVC
private typealias UploadMusicCells = UploadMusicTVC
private typealias Gestures = UploadMusicTVC
