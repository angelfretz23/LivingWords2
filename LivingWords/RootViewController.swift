//
//  RootViewController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/13/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit

/*
//rootviewcontroller holds the Page View Controller
class RootViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    //tells Swift we're going to instantiate a PVC
    var chapterPageViewController: UIPageViewController!
    //storyboard ID for child view controller
    private let identifier = ["ChildContentViewController"]
    //cachce of used child VCs
    private var cache = NSCache()
    private var observer: NSObjectProtocol!
    
    
    
    
    
    
    
    //object pool to return cached view controllers to avoid memory leaks. Used in the function viewControllerAtIndex below
    var cachedPageViewControllers = [Int: ChapterContentViewController]()
    

    //STEP 5- create array of VCs
    var chapters: NSArray!
    
    
    
    
    
    //MARK: - Page View Controller Datasource
    
    //STEP 4- conforming to datasource, required methods
    //when this method is called, passes reference to PVC, current VC and returns a VC.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? ChapterPageViewController
        {
            
            //if greater than 0, that means we are not on our very first VC and we can subtract 1 and still be able to go backwards to a previous VC
            let currentIndex = viewController.index
            return currentIndex > 0 ? viewControllerForPageAtIndex(index: currentIndex - 1): nil
        }
    }
        

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        if let viewController = viewController as? ChapterPageViewController
        {
            //- 1 will be the last vc in the array since index starts at 0, so assuming we are not at the very last one, the return the next vc which is index + 1
            let currentIndex = viewController.index
            return currentIndex < numberOfPages - 1 ? viewControllerForPageAtIndex(currentIndex + 1) : nil
        }

    }
    
    
    
    //STEP 6-helper method we create ourselves, return a VC at index array
    //when one of the methods above needs to return a vc,we find the index value of the array

    //reason for caching is otherwise would be creatinag a new instance of UIVC each time and creating memory leaks
    func viewControllerForPageAtIndex(index: Int) -> ChapterContentViewController
    {
        if let cachedPageViewController = cachedPageViewControllers[index]
        {
            return cachedPageViewController
        }

        // Create the page from your storyboard using a naming convention for pages.
        // e.g., Your page view controllers are labelled Page1, …2, etc.
        let viewControllerIdentifier = "Page\(index)"
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: viewControllerIdentifier) as? ChapterPageViewController else {
        fatalError("Non-PageViewController instance in viewControllerForPageAtIndex. Panic!")
        }
        pageViewController.index = index
    
        cachedPageViewControllers[index] = pageViewController
    
        return pageViewController

    }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //STEP 1- first instantiate PVC and it as a view to the root. Root VC loads instance of PVC.
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ChapterPageViewController") {
            self.addChildViewController(vc)
            self.view.addSubview(vc.view)
            
            //STEP 2- cast what we just instantiated as a PVC
            chapterPageViewController = vc as? UIPageViewController
            
            //STEP 3- conform to datasource and delegate, the viewcontroller will be the delegatee
            chapterPageViewController.dataSource = self
            chapterPageViewController.delegate = self
            
            
            //STEP 7- the PVC then loads the child VCs
            chapterPageViewController.setViewControllers([viewControllerForPageAtIndex(index: 0)], direction: .forward, animated: true, completion: { (nil) in
                //what do you want to do when you're done
                
            })
            
            //STEP 8- notify PVC that its done moving to parent 
            chapterPageViewController.didMove(toParentViewController: self)
            
        }
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

*/
