//
//  MediaContainerViewController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 1/31/17.
//  Copyright © 2017 Chandi Abey . All rights reserved.
//

import UIKit


//create keys for the names of the segues identifier already in storyboard
let SegueIdentifierFirst = "MusicVC"
let SegueIdentifierSecond = "SermonsVC"
let SegueIdentifierThird = "MoviesVC"
let SegueIdentifierFourth = "BooksVC"
let SegueIdentifierFifth = "ArticlesVC"


class MediaContainerViewController: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    

    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = segmentedControl.frame.size
    }
    


    
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
   
    //STEP 3- use lazy properties, instantiating child VCs when they are needed so if user never taps a segment, it wont be called
    lazy var musicViewController: MusicViewController =
    {
        //first load main storyboard from the bundle 
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        //then invoke the instantiate VC method on the storyboard and forcecast as type of view controller
        
        var viewController = storyboard.instantiateViewController(withIdentifier: SegueIdentifierFirst) as! MusicViewController
        
        //then add the viewController as a child VC to the container -NOTE this is a helper method we need to define below
        self.addViewControllerAsChildViewController(childViewController: viewController)
        
        return viewController
    }()
    
    
    
    
    lazy var sermonsViewController: SermonsViewController =
    {
            //first load main storyboard from the bundle
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            
            //then invoke the instantiate VC method on the storyboard
            
            var viewController = storyboard.instantiateViewController(withIdentifier: SegueIdentifierSecond) as! SermonsViewController
        
        
            //then add the viewController as a child VC to the container
            self.addViewControllerAsChildViewController(childViewController: viewController)
        
            return viewController
    }()
    
    
    
    lazy var moviesViewController: MoviesViewController =
        {
            //first load main storyboard from the bundle
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            
            //then invoke the instantiate VC method on the storyboard
            
            var viewController = storyboard.instantiateViewController(withIdentifier: SegueIdentifierThird) as! MoviesViewController
            
            //then add the viewController as a child VC to the container
            self.addViewControllerAsChildViewController(childViewController: viewController)
            
            return viewController
            
    }()
    
    
    lazy var booksViewController: BooksViewController =
        {
            //first load main storyboard from the bundle
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            
            //then invoke the instantiate VC method on the storyboard
            
            var viewController = storyboard.instantiateViewController(withIdentifier: SegueIdentifierFourth) as! BooksViewController
            
            //then add the viewController as a child VC to the container
            self.addViewControllerAsChildViewController(childViewController: viewController)
            
            return viewController
            
    }()
    
    
    lazy var articlesViewController: ArticlesViewController =
        {
            //first load main storyboard from the bundle
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            
            //then invoke the instantiate VC method on the storyboard
            
            var viewController = storyboard.instantiateViewController(withIdentifier: SegueIdentifierFifth) as! ArticlesViewController
            
            //then add the viewController as a child VC to the container
            self.addViewControllerAsChildViewController(childViewController: viewController)
            
            return viewController
            
    }()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //STEP 1
        setupView()
        
        
    }

    
    //MARK: - View Methods
    //1a
    private func setupView() {
        setupSegmentedControl()
        
        //call update view here so that the musicVC is showing when teh application is launched. 
        updateView()
    }
    
    //STEP 2 - another helper method for when selection is changed by the user, STEP 4- show or hide currently selected segment
    private func updateView()
    {
        musicViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
        sermonsViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
        moviesViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
        booksViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
        articlesViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
    }
   
    // MARK: -
    //1b
    private func setupSegmentedControl() {
        //first remove segments and add needed segments
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Music", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Sermons", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Movies", at: 2, animated: false)
        segmentedControl.insertSegment(withTitle: "Books", at: 3, animated: false)
        segmentedControl.insertSegment(withTitle: "Articles", at: 4, animated: false)
        
        //add action when triggered
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
    }
   
    
    
    
    
    //STEP 2a-action triggered when user selects segmented control
    func selectionDidChange(sender: UISegmentedControl)
    {
        updateView()
    }
    
    
    //STEP 3c- helper method
    //in this method we will see what the API looks like for view controller containment
    private func addViewControllerAsChildViewController(childViewController: UIViewController)
    {
        //tell container VC that we are going to add child VC
        addChildViewController(childViewController)
        
        //add child container's view as a subview of the view of the container view
        self.view.insertSubview(childViewController.view, at: 0)
        //then set the frame of child VC's view, use autoresizing mask for correct frame
        childViewController.view.frame = view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //notify child VC that it is added to container by invoking didMoveToParent on child VC
        childViewController.didMove(toParentViewController: self)
    
    }
    
}

