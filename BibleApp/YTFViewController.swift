//
//  YTDViewController.swift
//  YTDraggablePlayer
//
//  Created by Ana Paula on 5/23/16.
//  Copyright © 2016 Ana Paula. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class YTFViewController: UIViewController {
    
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var fullscreen: UIButton!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var minimizeButton: YTFPopupCloseButton!
    @IBOutlet weak var playerControlsView: UIView!
    @IBOutlet weak var backPlayerControlsView: UIView!
    @IBOutlet weak var slider: CustomSlider!
    @IBOutlet weak var progress: CustomProgress!
    @IBOutlet weak var entireTimeLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var progressIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var videoView: YTPlayerView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var tableViewMedia: UITableView!
    @IBOutlet weak var headerViewMedia: UIView!
    
    let mediaData = [MediaModel(title: "Movies", items: [MediaModelCell(imagePath: "", title: "Chris Tomlin - I Will Follow", titleBotton: ""),
                                                         MediaModelCell(imagePath: "", title: "MercyMe - I Can Only Imagine", titleBotton: ""),
                                                         MediaModelCell(imagePath: "", title: "Momentum Through Hearing God", titleBotton: "")
        ], typeOfMedia: .Other),
                     MediaModel(title: "Books", items: [MediaModelCell(imagePath: "", title: "I Will Follow", titleBotton: "Ivan"),
                                                        MediaModelCell(imagePath: "", title: "I Can Only Imagine", titleBotton: "Orest"),
                                                        MediaModelCell(imagePath: "", title: "Momentum", titleBotton: "Nazar"),
                                                        MediaModelCell(imagePath: "", title: "I Will Follow", titleBotton: "Ivan"),
                                                        MediaModelCell(imagePath: "", title: "I Can Only Imagine", titleBotton: "Orest"),
                                                        MediaModelCell(imagePath: "", title: "Momentum", titleBotton: "Nazar")
                        ], typeOfMedia: .Book),
                     MediaModel(title: "Sermous", items: [MediaModelCell(imagePath: "", title: "Hans Zimmer - Time", titleBotton: ""),
                                                          MediaModelCell(imagePath: "", title: "Coldplay - Paradise", titleBotton: ""),
                                                          MediaModelCell(imagePath: "", title: "In Bruge", titleBotton: "")
                        ], typeOfMedia: .Other),
                     MediaModel(title: "Music", items: [MediaModelCell(imagePath: "", title: "Real Madrid La Liga 17", titleBotton: ""),
                                                        MediaModelCell(imagePath: "", title: "Better Call Saul", titleBotton: ""),
                                                        MediaModelCell(imagePath: "", title: "Game of Thrones", titleBotton: "")
                        ], typeOfMedia: .Book),
                     MediaModel(title: "Rostik", items: [MediaModelCell(imagePath: "", title: "Inception", titleBotton: ""),
                                                        MediaModelCell(imagePath: "", title: "Binariks", titleBotton: ""),
                                                        MediaModelCell(imagePath: "", title: "Game of Thrones", titleBotton: "")
                        ], typeOfMedia: .Book)
    ]

    var tableViewDataSource: UITableViewDataSource?
    
    var videoID: String?
    var customView: UIView?
    var delegate: UITableViewDelegate?
    var dataSource: UITableViewDataSource?
    var tableCellNibName: String?
    var tableCellReuseIdentifier: String?
    
    var isOpen: Bool = false
    var isPlaying: Bool = false
    var isFullscreen: Bool = false
    var sliderValueChanged: Bool = false
    var isMinimized: Bool = false
    
    var hideTimer: Timer?
    
    var playerControlsFrame: CGRect?
    var playerViewFrame: CGRect?
    var tableViewContainerFrame: CGRect?
    var playerViewMinimizedFrame: CGRect?
    var minimizedPlayerFrame: CGRect?
    var initialFirstViewFrame: CGRect?
    var viewMinimizedFrame: CGRect?
    var restrictOffset: Float?
    var restrictTrueOffset: Float?
    var restictYaxis: Float?
    var transparentView: UIView?
    var onView: UIView?
    var playerTapGesture: UITapGestureRecognizer?
    var panGestureDirection: UIPanGestureRecognizerDirection?
    var touchPositionStartY: CGFloat?
    var touchPositionStartX: CGFloat?
    
    var playImage: UIImage?
    var pauseImage: UIImage?
    var fullscreenImage: UIImage?
    var unfullscreenImage: UIImage?
    var minimizeImage: UIImage?
    
    var subviewForDetailsView: UIView?
    var helper: MainMediaViewController?
    
    enum UIPanGestureRecognizerDirection {
        case Undefined
        case Up
        case Down
        case Left
        case Right
    }
    
    override func viewDidLoad() {
        
        initPlayerWithURLs()
        setupImageAssets()
        initViews()
        initDetailsView()
        initMediaTableView()
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        calculateFrames()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func initPlayerWithURLs() {
        
        if (isMinimized) {
            expandViews()
        }
        
        videoView.delegate = self
        
        if let videoID = videoID {
            videoView.isUserInteractionEnabled = false
            let playerVars = ["playsinline" : 1, "controls" : 0, "showinfo" : 0]
            videoView.load(withVideoId: videoID, playerVars: playerVars)
        }
    }
    
    func initViews() {
        
        self.view.backgroundColor = UIColor.clear
        self.view.alpha = 0.0
        playerControlsView.alpha = 0.0
        backPlayerControlsView.alpha = 0.0
        self.fullscreen.setImage(fullscreenImage, for: .normal)
        self.minimizeButton.setImage(minimizeImage, for: .normal)
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(YTFViewController.panAction(recognizer:)))
        playerView.addGestureRecognizer(gesture)
        self.playerTapGesture = UITapGestureRecognizer(target: self, action: #selector(YTFViewController.showPlayerControls))
        self.playerView.addGestureRecognizer(self.playerTapGesture!)
    }
    
    func initDetailsView() {
        
        if let view = subviewForDetailsView {
            view.removeFromSuperview()
        }
        
        if let _ = delegate, let _ = dataSource, let tableCellNibName = tableCellNibName, let tableCellReuseIdentifier = tableCellReuseIdentifier {
            
            let tableView = UITableView()
            tableView.delegate = delegate
            tableView.dataSource = dataSource
            
            tableView.register(UINib(nibName: tableCellNibName, bundle: Bundle.main), forCellReuseIdentifier: tableCellReuseIdentifier)
            
            tableView.frame.size = detailsView.frame.size
            subviewForDetailsView = tableView
        }
        
        if let customView = customView {
            customView.frame.size = detailsView.frame.size
            subviewForDetailsView = customView
        }
        
        if let subview = subviewForDetailsView {
            detailsView.addSubview(subview)
            detailsView.bringSubview(toFront: subview)
        }
    }
    
    func initMediaTableView() {
        
        tableViewMedia.delegate = self
        tableViewMedia.dataSource = tableViewDataSource
        
        tableViewMedia.register(UINib(nibName: "AllMediaTVCell", bundle: nil), forCellReuseIdentifier: "AllMediaTVCellIdentifier")
    }
    
    func calculateFrames() {
        
        self.initialFirstViewFrame = self.view.frame
        self.playerViewFrame = self.playerView.frame
        self.tableViewContainerFrame = self.tableViewContainer.frame
        self.playerViewMinimizedFrame = self.playerView.frame
        self.viewMinimizedFrame = self.tableViewContainer.frame
        self.playerControlsFrame = self.playerControlsView.frame
        
        playerView.translatesAutoresizingMaskIntoConstraints = true
        tableViewContainer.translatesAutoresizingMaskIntoConstraints = true
        playerControlsView.translatesAutoresizingMaskIntoConstraints = true
        backPlayerControlsView.translatesAutoresizingMaskIntoConstraints = true
        tableViewContainer.frame = self.initialFirstViewFrame!
        self.playerControlsView.frame = self.playerControlsFrame!
        
        transparentView = UIView.init(frame: initialFirstViewFrame!)
        transparentView?.backgroundColor = UIColor.black
        transparentView?.alpha = 0.0
        onView?.addSubview(transparentView!)
        
        self.restrictOffset = Float(self.initialFirstViewFrame!.size.width) - 200
        self.restrictTrueOffset = Float(self.initialFirstViewFrame!.size.height) - 180
        self.restictYaxis = Float(self.initialFirstViewFrame!.size.height - playerView.frame.size.height)
    }
    
    func setupImageAssets() {
        
        playImage = UIImage(named: "play")
        pauseImage = UIImage(named: "pause")
        fullscreenImage = UIImage(named: "fullscreen")
        unfullscreenImage = UIImage(named: "unfullscreen")
        unfullscreenImage = UIImage(named: "unfullscreen")
        minimizeImage = UIImage(named: "NowPlayingCollapseChevronMask")
    }
    
    func cuePlayerVideo() {
        
        if let videoID = videoID {
            videoView.cueVideo(byId: videoID, startSeconds: 0, suggestedQuality: .auto)
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func minimizeButtonTouched(sender: AnyObject) {
        
        minimizeViews()
    }
    
    @IBAction func closeMediaView(_ sender: UIButton) {
        removeViews()
    }
    
    
    func setupSlider(with duration: Double, currentTime: Float = 0.0) {
        
        slider.minimumValue = 0.0
        slider.maximumValue = Float(duration)
        slider.value = currentTime
    }
    
    
}

extension YTFViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let viewHeight = tableView.bounds.height
        let heightOther = viewHeight / 2
        
        if indexPath.row == 3 {
            return viewHeight / 1.5
        }
        
        return heightOther
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}

