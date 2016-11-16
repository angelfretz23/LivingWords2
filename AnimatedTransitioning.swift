//
//  AnimatedTransitioning.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/23/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit


//STEP 1: Since delegate's task is to manage the animator object that perfroms the actual animations, first create the animator class


//protocol performs the custom animations for transitioning between view controllers
class AnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    //used to determine if the presentation animation is presenting (as opposed to dismissing
    var isPresentation: Bool = false
    
    //returns the duration in seconds of the transition animation
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //get the from and two view controllers from the UIViewControllerContextTransitioning object
        
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        //then get the respective views of these view controllers
        let fromView = fromVC?.view
        let toVIew = toVC?.view
        //next get the containeerView
        let containerView = transitionContext.containerView
        
        // if the presentation animation is presenting, we add the to view to the container view
        if isPresentation {
            containerView.addSubview(toVIew!)
        }
        
        //decide which view controller to animate based on whether the transition is  a presentation or dismissal
        let animatingVC = isPresentation ? toVC: fromVC
        let animatingView = animatingVC?.view
        
        //then determine the start and end positions of the view
        let finalFrameForVC = transitionContext.finalFrame(for: animatingVC!)
        var initialFrameForVC = finalFrameForVC
        initialFrameForVC.origin.x += initialFrameForVC.size.width
        
        
        let initialFrame = isPresentation ? initialFrameForVC : finalFrameForVC
        let finalFrame = isPresentation ? finalFrameForVC : initialFrameForVC
        
     
        animatingView?.frame = initialFrame
        
        
        //Then in the animation, we move the view to the final position. This will animate the view from right to left during a presentation and vice versa during dismissal.
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 300.0,  initialSpringVelocity: 5.0, options: UIViewAnimationOptions.allowUserInteraction,animations:{
            animatingView?.frame = finalFrame
            }, completion:{ (value: Bool) in
                //If the transition is a dismissal, we remove the view.
                if !self.isPresentation {
                    fromView?.removeFromSuperview()
                }
                //Then we complete the transition by calling transitionContext.completeTransition().
                transitionContext.completeTransition(true)
        })
    }
        
    
    

}
