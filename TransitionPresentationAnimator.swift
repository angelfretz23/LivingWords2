//
//  TransitionPresentationAnimator.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/21/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//
//
//import UIKit
//
//class TransitionPresentationAnimator: NSObject {
//
//    
//    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> TimeInterval {
//        return 0.3
//    }
//    
//    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
//        let toViewController = transitionContext.viewController(forKey: UITransitionContextToViewControllerKey) as PresentationController
//        let containerView = transitionContext.containerView
//        
//        let animationDuration = self .transitionDuration(transitionContext: transitionContext)
//        
//        toViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1)
//        toViewController.view.layer.shadowColor = UIColor.blackColor().CGColor
//        toViewController.view.layer.shadowOffset = CGSizeMake(0.0, 2.0)
//        toViewController.view.layer.shadowOpacity = 0.3
//        toViewController.view.layer.cornerRadius = 4.0
//        toViewController.view.clipsToBounds = true
//        
//        containerView.addSubview(toViewController.view)
//        
//        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
//            toViewController.view.transform = CGAffineTransformIdentity
//            }, completion: { (finished) -> Void in
//                transitionContext.completeTransition(finished)
//        })
//    }
//
//
//}
