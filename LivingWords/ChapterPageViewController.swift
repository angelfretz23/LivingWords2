//
//  ChapterPageViewController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/13/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit

class ChapterPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {


    
    //create an array that we will be pulling chapters from the book the user selected
    var chapters: [Chapter] = [] {
        didSet {
            guard let chapter = chapter else { return }
            let initialViewController = self.createContentViewController(forPage: chapter.chapterNumber - 1)
            self.setViewControllers([initialViewController], direction: .forward, animated: false, completion: nil)
        }
    }
    
    //passing in 2 values from the bible list segue to these values
    var bookname: String?
    var chapter: Chapter?
    
    

    //create a property that will hold the cached VCs
    private let chapterContentViewControllerCache = NSCache<NSString, ChapterContentViewController>()
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: (self.view.frame.size.height + 40))

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let bookname = bookname, let chapter = chapter else { return }
        
    }
    
    //MARK:- Helper Methods for the datasource functions. Both datasource functions will need to return a VC at index array. we find the index value of the array of chapters returned by BookController. Reason for caching is otherwise would be creatinag a new instance of UIVC each time and creating memory leaks

    
    //finding the index value of the array
    private func indexOfChapter(forViewController viewController: UIViewController) -> Int
    {
        guard let contentViewController = viewController as? ChapterContentViewController else { fatalError("Unexpected view controller type in page view controller") }
        
        //NOTE: Had to unwrap this optional. Otherwise equatable protocol implemented on Chapter was not working.
        guard let chapter = contentViewController.chapter else { fatalError() }
        
        guard let viewControllerIndex = chapters.index(of: chapter) else {fatalError("Viewcontroller's chapter not found.") }
    
        return viewControllerIndex
    }
    

    //this function will either return a cached VC or create a new VC that will be cached
    private func createContentViewController(forPage pageIndex: Int) -> ChapterContentViewController {
      let chapter = chapters[pageIndex]
        
        if let cachedController = chapterContentViewControllerCache.object(forKey: chapter.identifier as NSString) {
            //return the cached viewcontroller
            return cachedController
        }
        else {
            //instantiate and configure a ChapterContentViewController for the Chapter
            guard let controller = storyboard?.instantiateViewController(withIdentifier: ChapterContentViewController.storyboardIdentifier) as? ChapterContentViewController else { fatalError("Unable to instantiate a ChapterContentViewController") }
            
            guard let bookname = bookname else { return ChapterContentViewController() }
            
            controller.configure(with: chapter, bookName: bookname)
            
            //cache the viewcontroller so it can be reused
            chapterContentViewControllerCache.setObject(controller, forKey: chapter.identifier as NSString)
            
            //return the newly created and cached viewcontroller
            return controller
        }
        
    }
    
    
    
    //MARK: - Page View Controller Datasource required methods

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let index = indexOfChapter(forViewController: viewController)
        
        //if greater than 0, that means we are not on our very first VC and we can subtract 1 and still be able to go backwards to a previous VC
        if index > 0 {
            return createContentViewController(forPage: index - 1)
        } else {
            return nil
        }
    }
        
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        //find the index for the current vc
        let index = indexOfChapter(forViewController: viewController)
        
        //- 1 will be the last vc in the array since index starts at 0, so assuming we are not at the very last one, the return the next vc which is index + 1
        if index < chapters.count - 1  {
            return createContentViewController(forPage: index + 1)
        } else {
            return nil
        }
    }

    //remove these so we dont show the dots at the bottom 
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return chapters.count
//    }
//    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        guard let currentViewController = pageViewController.viewControllers?.first else { return 0 }
//        
//        return indexOfChapter(forViewController: currentViewController)
//    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let bookname = bookname, let chapter = chapter else { return }
        let viewController = pageViewController.viewControllers?[0]
        self.navigationItem.title = viewController?.navigationItem.title
    }

        
    
        
    
}



