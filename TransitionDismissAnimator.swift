//
//  TransitionDismissAnimator.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/21/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//
//
//import UIKit
//
//class TransitionDismissAnimator: NSObject {
//
//    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> TimeInterval {
//        return 0.3
//    }
//    
//    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
//        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
//        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
//        let containerView = transitionContext.containerView
//        
//        let animationDuration = self .transitionDuration(transitionContext: transitionContext)
//        
//        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
//            fromViewController.view.alpha = 0.0
//            fromViewController.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//        }) { (finished) -> Void in
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        }
//    }
//    
//    
//
//}
