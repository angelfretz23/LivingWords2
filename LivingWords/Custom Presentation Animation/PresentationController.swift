//
//  PresentationController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/21/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import Foundation
import UIKit 


//presentationcontroller helps you switch out view controllers 
//adaptive allows us to specify the adaptive presentation style to use when presenting this controller
class PresentationController: UIPresentationController, UIAdaptivePresentationControllerDelegate {
    
    var chromeView: UIView = UIView()
    
    //method to set up the object and set up a dimming view
    //create a dark view- chromeView and set its alpha to 0 so it wont be initially visible. Then add a gesture recognizer to chromeView that will dismiss
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController!) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        chromeView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        chromeView.alpha = 0.0
        
        //the presented view controller must have a modalPresentationStyle of UIModalPresentationCustom for a custom presentation controller to be used
        //presentedViewController.modalPresentationStyle = .custom
        
        //add a gesture recongizer to the chrome view
        let tap = UITapGestureRecognizer(target: self, action: Selector(("chromeViewTapped:")))
        chromeView.addGestureRecognizer(tap)
    }
    
    //dismiss when chrome is tapped
    func chromeViewTapped(gesture: UITapGestureRecognizer)
        
    {
        if (gesture.state == UIGestureRecognizerState.ended) {
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    //MARK: Layout
    
    //frame rectangle for the presented view at end of animations
    private func frameOfPresentedViewInContainerView() -> CGRect {
        
        
        var presentedViewFrame = CGRect.zero
        let containerBounds = self.containerView?.bounds
        presentedViewFrame.size = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: (containerBounds?.size)!)
        presentedViewFrame.origin.x = (containerBounds?.size.width)! - presentedViewFrame.size.width
        return presentedViewFrame
        
//        //the presented view extends presentedViewContentSize.height points from the bottom edge of the screen
//        var presentedViewControllerFrame = containerViewBounds
//        presentedViewControllerFrame.size.height = presntedViewContentSIze.height
//        //presentedViewControllerFrame.origin.y = CGRectGetMaxY(containerViewBounds) - presentedViewContentSize.height
//        presentedViewControllerFrame.origin.x = 20.0
//        presentedViewControllerFrame.origin.y = 40.0
//        
//        return presentedViewControllerFrame
        }
    
    
    
    //when the presentation controller receives a viewWillTranitionTOSize: with TransitionCoordinator message, it calls this method to retrieve the new size for the presentedViewCotnroller's view. The presentation controller then sends a viwWillTransitionToSize:withTransitionCoordinator message to the presentedViewController with this size as the first argument . Note that it is up to the presentation controlle to adjust the frame of the presented view controller's view to match this promised size. We do this in containerViewWIllLayoutSubviews
    //returns the size of the specified child view contoroller content. here it is a third of the screen.
    func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize
    {
        
        return CGSize(width: (CGFloat(floorf(Float(parentSize.width/3.0)))), height: parentSize.height)
        
    }
   
   
    //set the chrome's frame and add it to the container view
    override func presentationTransitionWillBegin() {
        chromeView.frame = (self.containerView?.bounds)!
        chromeView.alpha = 0.0
        containerView?.insertSubview(chromeView, at: 0)
        let coordinator = presentedViewController.transitionCoordinator
        //check the value of the presented view controller's transition coordinator. transition coordinator is responsible for animating the presentation and dismissal of the content.
        if (coordinator != nil) {
            //if not nil, we use animatealongside to specify additional animations to be used alongside the presentation animation.
            coordinator!.animate( alongsideTransition: {
                (context: UIViewControllerTransitionCoordinatorContext!) -> Void in self.chromeView.alpha = 1.0
            }, completion: nil)
        } else {
            chromeView.alpha = 1.0
        }
    }
    
    
    //notifies presentation controller that layout is about to begin on the views of the container view. adjust frames so we have the right frames no matter what size phone.method is similar to the viewWillLayoutSubviews method in UIViewController. It allows the presentation controller to alter the layout of any custom views it manages.
    //This sets the frames of the chrome and presented views to the bounds of the container view. If this isn’t done then they won’t resize if the device is rotated
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
//        self.dimmingView.frame = self.containerView?.bounds ?? CGRect()
//        self.presentationWrappingView?.frame = self.frameOfPresentedViewInContainerView()
    }
    
    //determines whether the presentation will cover the full screen
    private func shouldPresentInFullScreen() -> Bool {
        return true
    }
    
    
    //presneted view should cover the full screen. we can return either .overfullscreen or .fullscreen. in overfullscreen if the presented view controller's view doesn't cover the underlying content, then the views under the presented view controller will be visible
    private func adaptivePresentationStyle() -> UIModalPresentationStyle {
        return UIModalPresentationStyle.fullScreen
    }
}



////MARK: Layout
//    
//    
//    //this method is invoked whenever the presentedViewControlelr's preferredConteneSize property changes. It is also invoked just before the presentation transition begins (prior to presentationTransitionWillBegin. 
//    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
//        super.preferredContentSizeDidChange(forChildContentContainer: container)
//        if container === self.presentedViewController {
//            self.containerView?.setNeedsLayout()
//        }
//    }
//    
//    
//    
//    
//    
// 
//    
//    
//
//    
//
//    
//    
//    //MARK: Tap Gesture Recognizer
//    @IBAction func dimmingViewTapped(sender: UITapGestureRecognizer) {
//        self.presentingViewController.dismiss(animated: true, completion: nil)
//    }
//    
//    
//    //MARK: UIViewControllerAnimatedTransitioning
//    
//    @objc func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return transitionContext?.isAnimated ?? false ? 0.35: 0
//    }
//    
//    //the presentation animation is tightly integrated with the overall presentation so it makes the most sense to implement UIViewControllerAnimatedTransitioning in the presentation controller rather than in a separate object
//    @objc func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
//        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
//        
//        
//        let containerView = transitionContext.containerView
//        
//        // For a Presentation:
//        //      fromView = The presenting view.
//        //      toView   = The presented view.
//        // For a Dismissal:
//        //      fromView = The presented view.
//        //      toView   = The presenting view.
//        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
//        // If NO is returned from -shouldRemovePresentersView, the view associated
//        // with UITransitionContextFromViewKey is nil during presentation.  This
//        // intended to be a hint that your animator should NOT be manipulating the
//        // presenting view controller's view.  For a dismissal, the -presentedView
//        // is returned.
//        //
//        // Why not allow the animator manipulate the presenting view controller's
//        // view at all times?  First of all, if the presenting view controller's
//        // view is going to stay visible after the animation finishes during the
//        // whole presentation life cycle there is no need to animate it at all — it
//        // just stays where it is.  Second, if the ownership for that view
//        // controller is transferred to the presentation controller, the
//        // presentation controller will most likely not know how to layout that
//        // view controller's view when needed, for example when the orientation
//        // changes, but the original owner of the presenting view controller does.
//        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
//        
//        let isPresenting = (fromViewController === self.presentingViewController)
//        
//        // This will be the current frame of fromViewController.view.
//        let _ = transitionContext.initialFrame(for: fromViewController!)
//        // For a presentation which removes the presenter's view, this will be
//        // CGRectZero.  Otherwise, the current frame of fromViewController.view.
//        var fromViewFinalFrame = transitionContext.finalFrame(for: fromViewController!)
//        // This will be CGRectZero.
//        var toViewInitialFrame = transitionContext.initialFrame(for: toViewController!)
//        // For a presentation, this will be the value returned from the
//        // presentation controller's -frameOfPresentedViewInContainerView method.
//        let toViewFinalFrame = transitionContext.finalFrame(for: toViewController!)
//        
//        // We are responsible for adding the incoming view to the containerView
//        // for the presentation (will have no effect on dismissal because the
//        // presenting view controller's view was not removed).
//        if( toView != nil ) {containerView.addSubview(toView!)}
//        
//        if isPresenting {
//            toViewInitialFrame.origin = CGPoint(x: (containerView.bounds.minX), y: containerView.bounds.maxY)
//            toViewInitialFrame.size = toViewFinalFrame.size
//            toView?.frame = toViewInitialFrame
//        } else {
//            // Because our presentation wraps the presented view controller's view
//            // in an intermediate view hierarchy, it is more accurate to rely
//            // on the current frame of fromView than fromViewInitialFrame as the
//            // initial frame (though in this example they will be the same).
//            fromViewFinalFrame = (fromView?.frame ?? CGRect()).offsetBy(dx: 0, dy: (fromView?.frame ?? CGRect()).height)
//        }
//        
//        let transitionDuration = self.transitionDuration(using: transitionContext)
//        
//        UIView.animate(withDuration: transitionDuration, animations: {
//            if isPresenting {
//                toView?.frame = toViewFinalFrame
//            } else {
//                fromView?.frame = fromViewFinalFrame
//            }
//            
//            }, completion: {finished in
//                // When we complete, tell the transition context
//                // passing along the BOOL that indicates whether the transition
//                // finished or not.
//                let wasCancelled = transitionContext.transitionWasCancelled
//                transitionContext.completeTransition(!wasCancelled)
//        })
//    }
//        
//        
//        
//        
//
//    
//    
//   
//    //AMRK: UIViewControllerTransitioningDelegate
//    
//    //if the modalPresentationStyle of the presented view controller is UIModalPresentationCustom, the system calls this method on the presented view controller's transitioningDelegate to retrieve the presentation controller that will manage the presentation. If your implementation returns nil, an instance of UIPresentationController is used.
//    
//    @objc func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//        assert(self.presentedViewController == presented, "You didn't initialize \(self) with the correct Presented View Controller")
//        return self
//    }
//    
//    
//    
//    
//    
//    //system calls this method on presented view controller's transitioningDelegate to retrieve the animator object used for animating the presentation of the incoming view controller. your implementation is expected to return an objec that conforms to the UIViewControllerAnimatedTransitioning protocol, or nil if the default presentation animation should be used
//    @objc func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return self
//    }
//    
//    
//    
//    //system calls this method on the presented view controller's transitioningDelegate to retrieve the animator object used for animating the dismissal of the presented view controller. your implementation is expected to return an object that conforms to the UIViewControllerAnimatedTransitioning protocol or nil if tht default dismisal animation should be used.
//    
//    @objc func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return self
//    }
//
//
//}
