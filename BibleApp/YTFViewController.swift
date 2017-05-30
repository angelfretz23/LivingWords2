//
//  YTDViewController.swift
//  YTDraggablePlayer
//
//  Created by Ana Paula on 5/23/16.
//  Copyright © 2016 Ana Paula. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import MediaPlayer
import AVKit
import SnapKit
import YTVimeoExtractor
import SVProgressHUD

class YTFViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var youTubePlayer: YTPlayerView!
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
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var allMediaCategory: UIButton!
    @IBOutlet weak var musicCategory: UIButton!
    @IBOutlet weak var sermonesCategory: UIButton!
    @IBOutlet weak var movieCategory: UIButton!
    @IBOutlet weak var bookCategory: UIButton!
    
    @IBOutlet weak var favorites: UIView!
    
    // MARK: - Properties
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
    
    var avController: AVPlayerViewController?
    var avPlayer: AVPlayer?
    var typeMedia = MediaType.youTube
    var youtubeId: String!
    
    var mediaType = Media.allMedia
    var mediaData: Verse?
    var mediaDataArr: [Verse]?

    
    let media = ["Movie", "Sermone", "Music", "Book"]
    
    enum UIPanGestureRecognizerDirection {
        case Undefined
        case Up
        case Down
        case Left
        case Right
    }
    
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        
        let panGestureYouTube = UITapGestureRecognizer(target: self, action: #selector(favoritesTapped(tapGestureRecognizer:)))
        favorites.addGestureRecognizer(panGestureYouTube)
        favorites.isUserInteractionEnabled = true
        
        initPlayerWithURLs()
        setupImageAssets()
        initViews()
        initDetailsView()
        initMediaTableView()
        initCollectionView()
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if typeMedia == .youTube {
            configureAVPlayerYouTube()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        calculateFrames()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    // MARK: - Custom Functions
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
     //   self.minimizeButton.setImage(minimizeImage, for: .normal)
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
        tableViewMedia.register(UINib(nibName: "ProfileMediaTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileMediaTableViewCellReuseID")
    }
    func initCollectionView() {
        collectionView.isHidden = true
        
        collectionView.register(UINib(nibName: "MediaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MediaCell")
        collectionView.register(UINib(nibName: "BookTypeCollectionVCell", bundle: nil), forCellWithReuseIdentifier: "BookTypeCollectionVCellID")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configureAVPlayerVimeo(with url: String) {

        let controller = AVPlayerViewController()
        controller.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 375, height: 211))
        
        YTVimeoExtractor.shared().fetchVideo(withVimeoURL: url, withReferer: nil) { (vimeoVideo, error) in
            
            if let video = vimeoVideo {
                
                let highQualityURL = video.highestQualityStreamURL()
                
                self.avController = AVPlayerViewController()
                self.avController?.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 375, height: 211))
                
                self.avPlayer = AVPlayer(url: highQualityURL)
                self.avController?.player = self.avPlayer
                
                self.addChildViewController(self.avController!)
                self.playerView.addSubview((self.avController?.view)!)
                
                self.avController?.player?.play()
            }
        }
        
    }
    
    func aflaViewYouTube() {
        let view = UIView()
            view.frame = playerView.frame
            view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.alpha = 0.1
        playerView.addSubview(view)
    }
    
    func configureAVPlayerYouTube() {
        let playerVars = ["playsinline" : 1, "controls" : 2, "showinfo" : 0]
        youTubePlayer.load(withVideoId: youtubeId, playerVars: playerVars)
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
    
    // MARK: - Choose media type
    @IBAction func AllMediaAction(_ sender: UIButton) {
        highlightsMedia(type: .allMedia, allMedia: allMediaCategory, music: musicCategory,
                        movies: movieCategory, sermones: sermonesCategory, books: bookCategory)
        
        collectionView.isHidden = true
        tableViewMedia.isHidden = false
   
        mediaType = .allMedia
    }
    
    @IBAction func MusicAction(_ sender: UIButton) {
        highlightsMedia(type: .music, allMedia: allMediaCategory, music: musicCategory,
                        movies: movieCategory, sermones: sermonesCategory, books: bookCategory)
    
        collectionView.isHidden = false
        tableViewMedia.isHidden = true
        
        mediaType = .music
        collectionView.reloadData()
    }
    
    @IBAction func SermonesAction(_ sender: UIButton) {
        highlightsMedia(type: .sermons, allMedia: allMediaCategory, music: musicCategory,
                        movies: movieCategory, sermones: sermonesCategory, books: bookCategory)
        
        collectionView.isHidden = false
        tableViewMedia.isHidden = true
        
        mediaType = .sermons
        collectionView.reloadData()
    }
    
    @IBAction func MovieAction(_ sender: UIButton) {
        highlightsMedia(type: .movies, allMedia: allMediaCategory, music: musicCategory,
                        movies: movieCategory, sermones: sermonesCategory, books: bookCategory)
        
        collectionView.isHidden = false
        tableViewMedia.isHidden = true
        
        mediaType = .movies
        collectionView.reloadData()
    }
    
    @IBAction func BookAction(_ sender: UIButton) {
        highlightsMedia(type: .books, allMedia: allMediaCategory, music: musicCategory,
                        movies: movieCategory, sermones: sermonesCategory, books: bookCategory)
        
        collectionView.isHidden = false
        tableViewMedia.isHidden = true
        
        mediaType = .books
        collectionView.reloadData()
    }
    
    fileprivate func switchTo(media_type: Media) {
        
        switch media_type {
        case .allMedia:
            mediaType = .allMedia
            
        case .books:
            mediaType = .books
            
        case .movies:
            mediaType = .movies
            
        case .music:
            mediaType = .music
            
        case .sermons:
            mediaType = .sermons
        }
    }
    
}

// MARK: - Extensions
extension YTFViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let viewHeight = tableView.bounds.height
        let heightOther = viewHeight / 1.8
        
        if indexPath.row == 3 {
            return viewHeight / 1.5
        }
        
        return heightOther
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
}

extension YTFViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch mediaType {
        case .books:
            return mediaData!.book!.count
            
        case .movies:
            return mediaData!.movie!.count
            
        case .music:
            return mediaData!.music!.count
            
        case .sermons:
             return mediaData!.sermon!.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch mediaType {
        case .books:
            return UICollectionViewCell.bookCell(collectionView, cellForItemAt: indexPath, mediaData: mediaData?.book)
            
        case .movies:
            return UICollectionViewCell.movieCell(collectionView, cellForItemAt: indexPath, mediaData: mediaData?.movie)
        
        case .music:
            return UICollectionViewCell.musicCell(collectionView, cellForItemAt: indexPath, mediaData: mediaData?.music)
            
        case .sermons:
            return UICollectionViewCell.sermonesCell(collectionView, cellForItemAt: indexPath, mediaData: mediaData?.sermon)
            
        default:
            print("")
        }
        
        return UICollectionViewCell()
    }
    
    // MARK:- cells depends on type media
    
}

extension YTFViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        Verse.saveToHistory(media_id: (mediaDataArr?[indexPath.row].id)!, madia_type: String(describing: mediaType), user_id: userID!, completion: { success in
//            if success {
//                SVProgressHUD.showSuccess(withStatus: "Saved")
//            }
//        })
    }
}

extension YTFViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let heightView = collectionView.bounds.height
        let widthView = collectionView.bounds.width
        let widthCell = (widthView / 2) - (0.03 * widthView)
        let heightCell = widthCell * 0.7
        
        let heightBook = heightView
        let widthBook = heightView * 0.7
        
        if mediaType == .books {
            return CGSize(width: widthBook, height: heightBook)
        }
        
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension YTFViewController {
    func favoritesTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        Verse.saveToHistory(media_id: 1, madia_type: String(describing: mediaType), user_id: userID!, completion: { success in
            if success {
                SVProgressHUD.showSuccess(withStatus: "Saved")
            }
        })
    }
}
