//
//  PresentAnimator.swift
//  LivingWords
//
//  Created by Chandi Abey  on 11/13/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit


class PresentAnimator: NSObject
{
    
    var initialY: CGFloat = 0
    
}

//animated transitioning protocol 

extension PresentAnimator: UIViewControllerAnimatedTransitioning
{
    
    //how long the animation takes
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    
    
    
    
    
    
    
    
    //the actual animation, transitionContext creates handles to actual view controllers involved in the transition so you can animate them
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //unwrap objects needed for animation
        //modal view controller, parentVC that sits behind modal VC, containerView is the stage in which this plays out
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else { return }
            let containerView = transitionContext.containerView
            //inserts the parent VC behind the modal
            containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        
        
        //code moves the toVC upward by one screen length
        let screenBounds = UIScreen.main.bounds
        
        //create a cgpoint located at the bottom left of the screen
        let topLeftCorner = CGPoint(x: 0, y: screenBounds.height)
        
        //destination frame of the modal which is positioned one screen length below viewable area. origin is set to the bottom left corner.
        let finalFrame = CGRect(origin: topLeftCorner, size: screenBounds.size)
        
        //a class method to animate views
        UIView.animate(withDuration: transitionContext as! TimeInterval,
                       animations: {
                        //moving modal from starting frame to final frame 
                        toVC.view.frame = finalFrame
                        }) { (_) in
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
    
    
}
