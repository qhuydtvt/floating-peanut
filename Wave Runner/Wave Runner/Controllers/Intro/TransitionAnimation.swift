//
//  TransitionAnimation.swift
//  Wave Runner
//
//  Created by Vũ Kiên on 22/01/2017.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class TransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        containerView.bringSubview(toFront: fromView)
        
        toView.alpha = 0.0
        
        UIView.animate(withDuration: 0.1, animations: {
            fromView.alpha = 0.0
        }) { (finished) in
            if finished {
                fromView.removeFromSuperview()
                UIView.animate(withDuration: 0.1, animations: {
                    toView.alpha = 1.0
                }, completion: { (_) in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            }
        }
    }
}
