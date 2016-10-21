//
//  PresentationManager.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/21/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit

    
//class PresentationManager: NSObject, UIViewControllerTransitioningDelegate {
//        
//        
//        //UIKit lets you customize VC presentation via delegate pattern, make main VC or another class adopt this delegate. IT callas the first method and if it returns nil, custom animation. if not, it calls on object returned by this method to perform transition.
//        
//        
//        //manager object that will be the transitioningDelegate object of the presented ViewController
//        //will load our UIPresentationController object
//        //will manager which object should handle the presentation and dismissal of the viewControllers
//        
//        
//        
//        
//        //each method is to create an instance of the other 3 objects
//        
//        func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//            let presentationController = PresentationController(presentedViewController: presented, presenting: source)
//            return presentationController
//        }
//        
//        
//        
//        //MARK:- Transition Delegate Methods-
//        
//        //method provides presentation object- UIKit will use this object as the animation method for the transition
//        func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//            return TransitionPresentationAnimator()
//            
//        }
//        
//        //method provides dismissal object
//        func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//            return TransitionDismissAnimator()
//            
//        }
//        
//        
//        
//        
//    }
//    
//
