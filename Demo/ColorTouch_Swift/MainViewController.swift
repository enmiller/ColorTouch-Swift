//
//  MainViewController.swift
//  ColorTouch_Swift
//
//  Created by Eric Miller on 6/3/14.
//  Copyright (c) 2014 Xero. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let gradientCircle: ENMCircle = ENMCircle(size: CGSizeMake(60.0, 60.0),
                                          redValue: 0.0,
                                        greenValue: 1.0,
                                         blueValue: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGrayColor()
        gradientCircle.fadeOutWithDuration(0.0)
    }
}

//MARK: - Touches
extension MainViewController {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (gradientCircle.superview == nil) {
            view.addSubview(gradientCircle)
        }
        
        if let touch = touches.first {
            let touchPoint: CGPoint = touch.locationInView(view)
            gradientCircle.center = touchPoint
            
            gradientCircle.fadeInWithDuration(0.2)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint: CGPoint = touch.locationInView(view)
            gradientCircle.center = touchPoint
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        gradientCircle.fadeOutWithDuration(0.2)
    }
}
