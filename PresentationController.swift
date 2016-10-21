//
//  PresentationController.swift
//  LivingWords
//
//  Created by Chandi Abey  on 10/21/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

//import Foundation
//import UIKit 
//
//class PresentationController: UIPresentationController {
//    
//    private var dimmingView: UIView?
//    private var presentationWrappingView: UIView?
//    
//    //method to set up the object and set up a dimming view
//    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
//        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
//        //setupDimmingView()
//        
//        
//        
//        //the presented view controller must have a modalPresentationStyle of UIModalPresentationCustom for a custom presentation controller to be used
//        presentedViewController.modalPresentationStyle = .custom
//    }
//    
//
////  setting up dimming view with blurred background and adding tap recognizer to dismiss the view when dimming view is tapped
//    func setupDimmingView() {
//        dimmingView = UIView(frame: presentingViewController.view.bounds)
//        
//        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark)) as UIVisualEffectView
//        visualEffectView.frame = dimmingView.bounds
//        visualEffectView.autoresizingMask = [.flexibleHeight , .flexibleWidth]
//        dimmingView.addSubview(visualEffectView)
//        
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: "dimmingViewTapped:")
//        dimmingView.addGestureRecognizer(tapRecognizer)
//    }
//    
//    func dimmingViewTapped(tapRecognizer: UITapGestureRecognizer) {
//        presentingViewController.dismiss(animated: true, completion: nil)
//    }
//    
//    
//    //one of the first methods invoked on the presentation controller at the start of a presentation. By the time this metho is called, the containerView has been created and the view hierarchy set up for the presentation. However the presentedView has not yet been retrieved.
//    override func presentationTransitionWillBegin() {
//       
//        //the default implementation of presentedView returns self.presentedViewController.view
//        let presentedViewControllerView = super.presentedView
//        
//        
//        //wrap the presented view controller's view in an intermediate hierarchy that applies a shadow and rounded corners to the top left and top right edges. The final effect is built using three intermediate views.
//        do {
//            let presentationWrapperView = UIView(frame: self.frameOfPresentedViewInContainerView())
//            presentationWrapperView.layer.shadowOpacity = 0.44
//            presentationWrapperView.layer.shadowRadius = 13.0
//            presentationWrapperView.layer.shadowOffset = CGSizeMake(0, -6.0)
//        }
//        
//        
//        let containerView = self.containerView
//       
//        
//        dimmingView.frame = (containerView?.bounds)!
//        dimmingView.alpha = 0.0
//        
//        containerView?.insertSubview(dimmingView, at: 0)
//        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (coordinatorContext) -> Void in
//            self.dimmingView.alpha = 1.0
//            }, completion: nil)
//    }
//    
//    
//    //notifies presentation controller that dimming animations are about to begin. Set dimming view's alpha value to 0 to make it disappear.
//    override func dismissalTransitionWillBegin() {
//        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (coordinatorContext) -> Void in
//            self.dimmingView.alpha = 0.0
//            }, completion: nil)
//    }
//    
//    
//    
//    //notifies presentation controller that layout is about to begin on the views of the container view. adjust frames so we have the right frames no matter what size phone.
//    override func containerViewWillLayoutSubviews() {
//        dimmingView.frame = (containerView?.bounds)!
//        presentedView?.frame = frameOfPresentedViewInContainerView()
//    }
//    
//    
//    //method specifies what size should the child, the view controller we are presenting have
//     func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
//        let currentDevice = UIDevice.current.userInterfaceIdiom
//        return CGSize(width: parentSize.width - 40.0, height: parentSize.height - 80.0)
//        
//    }
//    
//    
//    //frame rectangle for the presentation view at end of animations
//      override func frameOfPresentedViewInContainerView() -> CGRect {
//        var presentedViewFrame = CGRect.zero
//        let containerBounds = containerView?.bounds
//        
//        let contentContainer = presentedViewController
//        
//        presentedViewFrame.size = sizeForChildContentContainer(container: contentContainer, withParentContainerSize: (containerBounds?.size)!) //CGSizeMake(428.0, presentedView().frame.size.height) //
//        presentedViewFrame.origin.x = 20.0
//        presentedViewFrame.origin.y = 40.0
//        
//        return presentedViewFrame
//    }
//}
