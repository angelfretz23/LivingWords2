//
//  TransitioningDelegate.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/23/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit

class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    
    //returns a presentation controller that manages the presentation of a view controller and return an instance of the presentation controller we created
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController) -> UIPresentationController? {
        let presentationController = PresentationController(presentedViewController:presented, presenting:presenting)
        
        return presentationController
    }
    
    // returns an animator object that will be used when a view controller is being presented,
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        var animationController = AnimatedTransitioning()
        animationController.isPresentation = true
        return animationController
    }
    
    //returns the animation controller to be used in dismissing the view controller.
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        var animationController = AnimatedTransitioning()
        animationController.isPresentation = false
        return animationController
    }
    
    
    
    
}
